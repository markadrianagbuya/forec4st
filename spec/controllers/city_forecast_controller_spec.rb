require 'rails_helper'

RSpec.describe CityForecastController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      stub_request(:get, "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1105779&format=json").
      to_return(headers: { "content-type" => "application/json" }, status: 200, body: File.read(File.join(Rails.root, "spec/fixtures/sydney_weather_response.json")))
      
      get :show

      expect(response).to have_http_status(:success)
    end
  end

end
