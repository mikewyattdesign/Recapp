class AddEventIdToLocations < ActiveRecord::Migration
  def change
    add_reference :locations, :event, index: true
    remove_column :events, :location_id
    remove_column :events, :weather_id
  end
end
