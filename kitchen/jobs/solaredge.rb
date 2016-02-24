require 'net/https'
require 'json'
require_relative '../configuration'

SCHEDULER.every '10m', :first_in => 0 do |job|
  http = Net::HTTP.new("monitoringapi.solaredge.com", 443)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  response = http.request(Net::HTTP::Get.new("/site/#{SOLAREDGE_SITE_ID}/overview.json?api_key=#{SOLAREDGE_API_KEY}"))
  data = JSON.parse(response.body)
  current_power = data["overview"]["currentPower"]["power"]
  today_energy = data["overview"]["lastDayData"]["energy"]

  puts "energy: #{today_energy}"
  puts "current: #{current_power}"

  send_event('solaredge', { currentPower: "#{current_power}", todayEnergy: "#{today_energy}" })
end
