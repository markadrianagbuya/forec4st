require 'yahoo_weather'
require 'temperature'

DailyForecast = Struct.new(:date, :high, :low, :description)

class CityForecastsController < ApplicationController
  def show
    @city = params[:city]
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
        Temperature.fahrenheit_to_celsius(forecast["high"]).round(1),
        Temperature.fahrenheit_to_celsius(forecast["low"]).round(1),
        forecast["text"]
      )
    end

    @daily_forecasts.each do |daily_forecast|
      DayForecast.create!(
        forecasted_at: Time.parse(response["query"]["created"]),
        forecast_date: daily_forecast.date,
        high: daily_forecast.high,
        low: daily_forecast.low,
        city: @city,
        description: daily_forecast.description
      )
    end
  end
end
