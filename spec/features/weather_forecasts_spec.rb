require 'rails_helper'

RSpec.feature "Weather forecasts", type: :feature do
  scenario "User can see the weather forecast of Sydney" do
    visit "/"

    stub_request(:get, "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1105779&format=json").
    to_return(headers: { "content-type" => "application/json" }, status: 200, body: File.read(File.join(Rails.root, "spec/fixtures/sydney_weather_response.json")))
    click_link "View Sydney Weather Forecast"

    expect(page).to have_text "Sydney"
    expect(page).to have_text "26.7°C"
  end
end
