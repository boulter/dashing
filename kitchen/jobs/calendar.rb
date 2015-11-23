require 'icalendar'
require 'net/http'
require 'net/https'
require_relative 'config'

uri = URI ICAL_URL

SCHEDULER.every '15m', :first_in => 0 do |job|

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.request(Net::HTTP::Get.new(uri.path))
  result = response.body
  calendars = Icalendar.parse(result)
  calendar = calendars.first

  events = calendar.events.map do |event|
    {
      start: event.dtstart,
      end: event.dtend,
      summary: event.summary,
      is_all_day: event.dtstart.class.name == "Icalendar::Values::Date" 
    }
  end.select { |event| event[:start] > DateTime.now }

  events = events.sort { |a, b| a[:start] <=> b[:start] }
  
  puts "loaded #{ events.length } upcoming calendar events"
  events = events[0..8]
  
  send_event('calendar', { events: events })
end
