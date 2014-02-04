class DropEventsWeathers < ActiveRecord::Migration
  def change
    drop_join_table :events, :weathers
    add_reference :weathers, :event, index: true
  end
end
