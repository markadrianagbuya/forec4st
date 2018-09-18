require 'temperature'

class CityForecast
  class << self
    def from_yahoo_weather_response(response)
      new(day_forecasts(response), city(response))
    end

    def days_in_city_forecast
      4
    end

    private

    def day_forecasts(response)
      next_forecast_objects = forecast_objects(response).first(days_in_city_forecast)
      next_forecast_objects.map do |forecast|
        DayForecast.new(
          forecasted_at: forecasted_at(response),
          forecast_date: forecast["date"],
          high: Temperature.fahrenheit_to_celsius(forecast["high"]).round(1),
          low: Temperature.fahrenheit_to_celsius(forecast["low"]).round(1),
          city: city(response),
          description: forecast["text"]
        )
      end
    end

    def forecasted_at(response)
      DateTime.parse(response["query"]["created"])
    end

    def forecast_objects(response)
      recast_json_objects = response.dig("query", "results", "channel", "item", "forecast")
    end

    def city(response)
      response.dig("query", "results", "channel", "location", "city").downcase
    end
  end

  attr_accessor :day_forecasts, :city

  def initialize(day_forecasts, city)
    self.day_forecasts = day_forecasts
    self.city = city
  end

  def persist_day_forecasts!
    day_forecasts.each(&:save!)
  end

  def title
    city.titleize
  end
end
