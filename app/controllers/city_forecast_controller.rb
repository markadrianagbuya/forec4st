class CityForecastController < ApplicationController
  def show
    response = HTTParty.get('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1105779&format=json')
    temperature_in_fahrenheit = response["query"]["results"]["channel"]["item"]["forecast"].first["high"].to_d
    @temperature = (temperature_in_fahrenheit - 32.to_d) / 1.8.to_d
  end
end
