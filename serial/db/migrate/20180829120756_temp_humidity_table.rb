class TempHumidityTable < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_humd do |t|
      t.float :temperature
      t.float :humidity
      t.timestamps
    end
  end
end
