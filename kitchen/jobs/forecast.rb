require 'net/https'
require 'json'
require_relative '../configuration'

# Forecast API Key from https://developer.forecast.io
forecast_api_key = DARK_SKY_API_KEY

# Latitude, Longitude for location
forecast_location_lat = "42.448139"
forecast_location_long = "-71.2601079"

# Unit Format
# "us" - U.S. Imperial
# "si" - International System of Units
# "uk" - SI w. windSpeed in mph
forecast_units = "us"

SCHEDULER.every '30m', :first_in => 0 do |job|
  http = Net::HTTP.new("api.forecast.io", 443)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  response = http.request(Net::HTTP::Get.new("/forecast/#{forecast_api_key}/#{forecast_location_lat},#{forecast_location_long}?units=#{forecast_units}"))
  forecast = JSON.parse(response.body)
  forecast_current_temp = forecast["currently"]["temperature"].round
  forecast_current_icon = forecast["currently"]["icon"]
  forecast_current_desc = forecast["currently"]["summary"]
  if forecast["minutely"]  # sometimes this is missing from the response.  I don't know why
    forecast_next_desc  = forecast["minutely"]["summary"]
    forecast_next_icon  = forecast["minutely"]["icon"]
  else
    puts "Did not get minutely forecast data again"
    forecast_next_desc  = "No data"
    forecast_next_icon  = ""
  end

  daily = forecast["daily"]["data"][0]
  forecast_high_temp = daily["temperatureMax"].round
  forecast_low_temp = daily["temperatureMin"].round

  forecast_later_desc   = forecast["hourly"]["summary"]
  forecast_later_icon   = forecast["hourly"]["icon"]

  data = { current_temp: "#{forecast_current_temp}&deg;", current_icon: "#{forecast_current_icon}", current_desc: "#{forecast_current_desc}", next_icon: "#{forecast_next_icon}", next_desc: "#{forecast_next_desc}", later_icon: "#{forecast_later_icon}", later_desc: "#{forecast_later_desc}", forecast_high_temp: "#{forecast_high_temp}", forecast_low_temp: "#{forecast_low_temp}"}

  puts data

  send_event('forecast', data)
end
