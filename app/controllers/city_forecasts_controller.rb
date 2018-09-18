class CityForecastsController < ApplicationController
  def show
    @city = params[:city].downcase
    case @city
    when "sydney"
      response = HTTParty.get('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1105779&format=json')
    when "melbourne"
      response = HTTParty.get('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1103816&format=json')
    end

    temperature_in_fahrenheit = response["query"]["results"]["channel"]["item"]["forecast"].first["high"].to_d
    @temperature = (temperature_in_fahrenheit - 32.to_d) / 1.8.to_d
  end
end
