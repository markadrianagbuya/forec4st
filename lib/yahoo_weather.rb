require 'httparty'

class YahooWeather
  def weather_for_sydney
    HTTParty.get('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1105779&format=json').parsed_response
  end

  def weather_for_melbourne
    HTTParty.get('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1103816&format=json').parsed_response
  end
end
