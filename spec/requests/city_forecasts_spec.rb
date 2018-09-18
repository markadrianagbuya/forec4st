require 'rails_helper'

RSpec.describe "CityForecasts", type: :request do
  describe "GET /city_forecasts/sydney" do
    it "shows the forecasts for sydney" do
      stub_request(:get, "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1105779&format=json").
      to_return(headers: { "content-type" => "application/json" }, status: 200, body: File.read(File.join(Rails.root, "spec/fixtures/sydney_weather_response.json")))

      get city_forecast_path("sydney")

      expect(response).to have_http_status(200)
      expect(response.body).to include("26.7°C")
    end
  end
end
