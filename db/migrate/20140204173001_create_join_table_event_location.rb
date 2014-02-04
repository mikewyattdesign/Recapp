class CreateJoinTableEventLocation < ActiveRecord::Migration
  def change
    create_join_table :events, :locations do |t|
      # t.index [:event_id, :location_id]
      # t.index [:location_id, :event_id]
    end
  end
end
