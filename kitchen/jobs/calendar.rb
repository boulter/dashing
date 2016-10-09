require 'time'
require 'date'
require 'icalendar'
require 'icalendar/recurrence'
require 'net/http'
require 'net/https'
require 'tzinfo'
require_relative '../configuration'

uri = URI ICAL_URL
tz = TZInfo::Timezone.get('America/New_York')

SCHEDULER.every '15m', :first_in => 0 do |job|

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.request(Net::HTTP::Get.new(uri.path))
  result = response.body
  calendars = Icalendar.parse(result)
  calendar = calendars.first

  now = DateTime.now
  today = Date.new(now.year, now.mon, now.mday);
  tomorrow = Date.new(now.year, now.mon, now.mday + 1);
  next_week = now + 7
  puts "now:" + now.to_s
  puts "today:" + today.to_s
  puts "end:" + next_week.to_s

  events = []
  calendar.events.each do |event|
    recurrent_events = event.occurrences_between(now, next_week)
    if recurrent_events
      recurrent_events.each do |revent|
        allday = (revent.end_time == revent.start_time + (60*60*24))
        if allday or now.to_s < revent.end_time.to_s
          evt = { summary: event.summary, start: DateTime.parse(revent.start_time.to_s), end: DateTime.parse(revent.end_time.to_s), is_all_day: allday }
          events.push(evt)
        end
      end
    end
  end

  events = events.sort { |a, b| a[:start] <=> b[:start] }

  puts "loaded #{ events.length } upcoming calendar events"
  events = events[0..7]

  events.each do |event|
     puts " #{event[:start]} - #{event[:end]}: #{event[:summary]}"
  end

  send_event('calendar', { events: events })
end
