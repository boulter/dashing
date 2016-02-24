require 'time'
require 'date'
require 'icalendar'
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
  next_week = now + 7
  puts "now:" + now.to_s
  puts "end:" + next_week.to_s

  events = calendar.events.map do |event|
    {
      start: tz.local_to_utc(DateTime.parse(event.dtstart.to_s)),
      end: tz.local_to_utc(DateTime.parse(event.dtend.to_s)),
      summary: event.summary,
      is_all_day: event.dtstart.class.name == "Icalendar::Values::Date"
    }
  end.select { |event| event[:start] > now && event[:start] < next_week }

  events = events.sort { |a, b| a[:start] <=> b[:start] }

  puts "loaded #{ events.length } upcoming calendar events"
  events = events[0..5]

  events.each do |event|
     puts " #{event[:start]} - #{event[:end]}: #{event[:summary]}"
  end

  send_event('calendar', { events: events })
end
