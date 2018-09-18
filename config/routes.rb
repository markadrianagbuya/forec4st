Rails.application.routes.draw do
  root 'weather#index'
  get 'city_forecast/:city', to: 'city_forecasts#show', as: "city_forecast", constraints: { city: /(sydney|melbourne)/ }
end
