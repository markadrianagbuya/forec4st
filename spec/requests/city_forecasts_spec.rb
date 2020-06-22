require 'rails_helper'

RSpec.describe "CityForecasts", type: :request do
  describe "GET /city_forecasts/:city" do

    it "shows the forecasts for sydney when city is sydney" do
      stub_request(:get, "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1105779&format=json").
      to_return(headers: { "content-type" => "application/json" }, status: 200, body: File.read(File.join(Rails.root, "spec/fixtures/sydney_weather_response.json")))

      expect do
        get city_forecast_path("sydney")
      end.to change(DayForecast, :count).by(4)

      expect(response).to have_http_status(200)
      expect(response.body).to include("Sydney")
      expect(response.body).to include("26.7°C")

      expect(DayForecast.where(forecasted_at: Time.parse("2018-09-18T10:44:35Z"), forecast_date: Date.new(2018, 9, 18), city: "sydney", high: 26.7, low: 7.2, description: "Sunny")).to exist
      expect(DayForecast.where(forecasted_at: Time.parse("2018-09-18T10:44:35Z"), forecast_date: Date.new(2018, 9, 19), city: "sydney", high: 27.2, low: 10.6, description: "Sunny")).to exist
      expect(DayForecast.where(forecasted_at: Time.parse("2018-09-18T10:44:35Z"), forecast_date: Date.new(2018, 9, 20), city: "sydney", high: 16.1, low: 7.8, description: "Rain")).to exist
    end

    it "shows the forecasts for melbourne when city is melbourne" do
      stub_request(:get, "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1103816&format=json").
      to_return(headers: { "content-type" => "application/json" }, status: 200, body: File.read(File.join(Rails.root, "spec/fixtures/melbourne_weather_response.json")))

      get city_forecast_path("melbourne")

      expect(response).to have_http_status(200)
      expect(response.body).to include("Melbourne")
      expect(response.body).to include("18.3°C")
    end

    it "returns a 404 response if city is unexpected" do
      expect do
        get "/city_forecast/adelaide"
      end.to raise_error(ActionController::RoutingError)
    end
  end
end
