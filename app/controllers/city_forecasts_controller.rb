require 'yahoo_weather'
require 'temperature'

DailyForecast = Struct.new(:date, :high, :low, :description)

class CityForecastsController < ApplicationController
  def show
    @city = params[:city].downcase
    case @city
    when "sydney"
      response = YahooWeather.new.weather_for_sydney
    when "melbourne"
      response = YahooWeather.new.weather_for_melbourne
    end

    daily_forecast_json_objects = response["query"]["results"]["channel"]["item"]["forecast"]
    @daily_forecasts = daily_forecast_json_objects.first(3).map do |forecast| 
      DailyForecast.new(
        forecast["date"],
        Temperature.fahrenheit_to_celsius(forecast["high"]),
        Temperature.fahrenheit_to_celsius(forecast["low"]),
        forecast["text"]
      )
    end
  end
end
