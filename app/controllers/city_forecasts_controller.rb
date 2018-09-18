require 'yahoo_weather'
require 'temperature'

class CityForecastsController < ApplicationController
  def show
    @city = params[:city]
    case @city
    when "sydney"
      response = YahooWeather.new.weather_for_sydney
    when "melbourne"
      response = YahooWeather.new.weather_for_melbourne
    end

    day_forecast_json_objects = response["query"]["results"]["channel"]["item"]["forecast"]
    @day_forecasts = day_forecast_json_objects.first(3).map do |forecast| 
      DayForecast.create!(
        forecasted_at: Time.parse(response["query"]["created"]),
        forecast_date: forecast["date"],
        high: Temperature.fahrenheit_to_celsius(forecast["high"]).round(1),
        low: Temperature.fahrenheit_to_celsius(forecast["low"]).round(1),
        city: @city,
        description: forecast["text"]
      )
    end
  end
end
