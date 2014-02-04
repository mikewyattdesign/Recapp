class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.integer :temperature
      t.integer :precipitation
      t.integer :wind_chill
      t.integer :heat_index
      t.integer :wind_speed

      t.timestamps
    end
  end
end
