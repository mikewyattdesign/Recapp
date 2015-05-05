class CreateEventsFavoritePhotos < ActiveRecord::Migration
  def change
    create_table :events_favorite_photos do |t|
        t.integer :event_id
        t.integer :photo_id
        t.integer :order
    end
  end
end