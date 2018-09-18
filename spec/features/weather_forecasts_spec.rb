require 'rails_helper'

RSpec.feature "Weather forecasts", type: :feature do
  scenario "User can see the weather forecast of Sydney" do
    visit "/"

    click_link "View Sydney Weather Forecast"

    expect(page).to have_text "Sydney"
    expect(page).to have_text "26.7°C"
  end
end
