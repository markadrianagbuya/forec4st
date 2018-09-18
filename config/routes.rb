Rails.application.routes.draw do
  root 'weather#index'
  get 'city_forecast/show'
end
