require 'rails_helper'

RSpec.feature "Weather forecasts", type: :feature do
  scenario "User can see the daily weather forecast of Sydney for the next few days" do
    visit "/"

    stub_request(:get, "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D1105779&format=json").
    to_return(headers: { "content-type" => "application/json" }, status: 200, body: File.read(File.join(Rails.root, "spec/fixtures/sydney_weather_response.json")))
    click_link "View Sydney Weather Forecast"

    expect(page).to have_text "Sydney"
    expect(page).to have_text "18 Sep 2018"
    expect(page).to have_text "Sunny"
    expect(page).to have_text "26.7°C"
    expect(page).to have_text "7.2°C"

    expect(page).to have_text "19 Sep 2018"
    expect(page).to have_text "Sunny"
    expect(page).to have_text "27.2°C"
    expect(page).to have_text "10.6°C"

    expect(page).to have_text "20 Sep 2018"
    expect(page).to have_text "Rain"
    expect(page).to have_text "16.1°C"
    expect(page).to have_text "7.8°C"
  end
end
