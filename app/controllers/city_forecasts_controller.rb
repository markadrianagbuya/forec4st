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
    @temperature = Temperature.fahrenheit_to_celsius(temperature_in_fahrenheit)
  end
end
