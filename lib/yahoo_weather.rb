require 'httparty'
require 'uri'

class YahooWeather
  include HTTParty
  base_uri 'https://query.yahooapis.com'

  def weather_for_sydney
    city_forcast("sydney")
  end

  def weather_for_melbourne
    city_forcast("melbourne")
  end

  private

  def city_forcast(city)
    self.class.get('/v1/public/yql', city_forecast_options(city)).parsed_response
  end

  def city_forecast_options(city)
    {
      query: {
        q: "select * from weather.forecast where woeid=#{woeid_for_city(city)}",
        format: "json"
      }
    }
  end

  def woeid_for_city(city)
    {
      "sydney" => 1105779,
      "melbourne" => 1103816
    }[city]
  end
end
