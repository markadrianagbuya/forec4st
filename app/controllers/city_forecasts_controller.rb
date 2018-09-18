class CityForecastsController < ApplicationController
  def show
    @city = params[:city].downcase
    case @city
    when "sydney"
      response = YahooWeather.new.weather_for_sydney
    when "melbourne"
      response = YahooWeather.new.weather_for_melbourne
    end

    temperature_in_fahrenheit = response["query"]["results"]["channel"]["item"]["forecast"].first["high"].to_d
    @temperature = (temperature_in_fahrenheit - 32.to_d) / 1.8.to_d
  end
end
