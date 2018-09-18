require 'spec_helper'
require 'yahoo_weather'

RSpec.describe YahooWeather do
  describe "#weather_for_sydney" do
    it "returns the json for the weather in sydney" do
      sydney_json_response = File.read("spec/fixtures/sydney_weather_response.json")
      stub_request(:get, "https://query.yahooapis.com/v1/public/yql").with(query: { "q" => "select * from weather.forecast where woeid=1105779", "format" => :json }).
      to_return(headers: { "content-type" => "application/json" }, status: 200, body: sydney_json_response)

      expect(YahooWeather.new.weather_for_sydney).to eq JSON.parse(sydney_json_response)
    end
  end

  describe "#weather_for_melbourne" do
    it "returns the json for the weather in melbourne" do
      melbourne_json_response = File.read("spec/fixtures/melbourne_weather_response.json")
      stub_request(:get, "https://query.yahooapis.com/v1/public/yql").with(query: { "q" => "select * from weather.forecast where woeid=1103816", "format" => :json }).
      to_return(headers: { "content-type" => "application/json" }, status: 200, body: melbourne_json_response)

      expect(YahooWeather.new.weather_for_melbourne).to eq JSON.parse(melbourne_json_response)
    end
  end
end
