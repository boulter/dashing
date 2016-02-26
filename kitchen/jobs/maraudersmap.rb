require 'net/http'
require 'net/https'
require 'json'
require_relative '../configuration'

SCHEDULER.every '2m', :first_in => 0 do |job|

  icons = {
    "Jeff"=>"/assets/jeff.png",
    "Anne"=>"/assets/anne.png"
  }

  params = [
    {
      "label"=>"Jeff",
      "username"=>"apple@boulter.com",
      "password"=>ICLOUD_PASSWORD_JEFF,
      "icon"=>"/assets/jeff.jpg",
      "deviceid"=>'UvEq+TEmCYE62MQ05IdeK5/owQHSAtg/WiACGYuPAakLxgq7r2imL+HYVNSUzmWV'
    },
    {
      "label"=>"Anne",
      "username"=>"anne@boulter.com",
      "password"=>ICLOUD_PASSWORD_ANNE,
      "icon"=>"/assets/anne.jpg",
      "deviceid"=>'ihbPn6/ImyCYk2fKG/z8cLAfvWKtw3TbrSze4i4+BsYVWS8DrRsWvuHYVNSUzmWV'
    }
  ]

  params_json = JSON.dump(params)
#  puts params_json
  cmd = "lib/findmyphones.py '" + params_json + "'"
  out = `#{cmd}`
#  puts out
  locations = JSON.load(out)

#  puts locations

  locations.each do |key, loc|
      uri = URI.parse("https://maps.googleapis.com/maps/api/directions/json")
      args = {origin: "#{loc['latitude']},#{loc['longitude']}", destination: HOME_COORDS, key: GOOGLE_API_KEY}
      uri.query = URI.encode_www_form(args)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      directions = JSON.parse(response.body)

      loc['icon'] = icons[key]

      loc['minutesToHome'] = directions['routes'][0]['legs'][0]['duration']['value'] / 60
      loc['distanceToHome'] = directions['routes'][0]['legs'][0]['distance']['value'] / 1609.34

  end

  send_event('timetohome', { locations: locations })
  send_event('maraudersmap', { locations: locations })
end
