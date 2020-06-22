require 'yahoo_weather'
require 'temperature'

class CityForecastsController < ApplicationController
  def show
    case params[:city]
    when "sydney"
      response = YahooWeather.new.weather_for_sydney
    when "melbourne"
      response = YahooWeather.new.weather_for_melbourne
    end

    @city_forecast = CityForecast.from_yahoo_weather_response(response)
    @city_forecast.persist_day_forecasts!
  end
end
