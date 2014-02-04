class CreateJoinTableEventPhoto < ActiveRecord::Migration
  def change
    create_join_table :events, :photos do |t|
      # t.index [:event_id, :photo_id]
      # t.index [:photo_id, :event_id]
    end
  end
end
