require 'rails_helper'

RSpec.describe CityForecast do
  describe "#persist_day_forecasts!" do
    it "calls save on the day forecasts" do
      day_forecasts = [spy, spy]
      city_forecast = CityForecast.new(day_forecasts, "sydney")
      city_forecast.persist_day_forecasts!
      day_forecasts.each do |day_forecast|
        expect(day_forecast).to have_received(:save!)
      end
    end
  end

  describe "#title" do
    it "returns the city in titleized form" do
      expect(CityForecast.new([], "melbourne").title).to eq "Melbourne"
    end
  end

  describe ".from_yahoo_weather_response" do
    it "returns a CityForecast with the DayForecasts and city" do
      json_response = JSON.parse(File.read("spec/fixtures/sydney_weather_response.json"))
      city_forecast = CityForecast.from_yahoo_weather_response(json_response)
      expected_day_forecasts = [
        { id: nil, forecasted_at: DateTime.parse("2018-09-18T10:44:35Z"), forecast_date: Date.new(2018, 9, 18), city: "sydney", high: 26.7, low: 7.2, description: "Sunny" },
        { id: nil, forecasted_at: DateTime.parse("2018-09-18T10:44:35Z"), forecast_date: Date.new(2018, 9, 19), city: "sydney", high: 27.2, low: 10.6, description: "Sunny" },
        { id: nil, forecasted_at: DateTime.parse("2018-09-18T10:44:35Z"), forecast_date: Date.new(2018, 9, 20), city: "sydney", high: 16.1, low: 7.8, description: "Rain" },
        { id: nil, forecasted_at: DateTime.parse("2018-09-18T10:44:35Z"), forecast_date: Date.new(2018, 9, 21), city: "sydney", high: 20.6, low: 5.6, description: "Sunny" }
      ].map(&:stringify_keys)
      expect(city_forecast.title).to eq "Sydney"
      expect(city_forecast.day_forecasts.map(&:attributes)).to match expected_day_forecasts
    end
  end
end
