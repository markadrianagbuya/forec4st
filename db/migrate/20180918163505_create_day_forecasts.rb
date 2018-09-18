class CreateDayForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :day_forecasts do |t|
      t.time :forecasted_at
      t.date :forecast_date
      t.string :city
      t.float :high
      t.float :low
      t.string :description
    end
  end
end
