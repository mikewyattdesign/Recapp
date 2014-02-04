class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :events, :weathers do |t|
      # t.index [:event_id, :weather_id]
      # t.index [:weather_id, :event_id]
    end
  end
end
