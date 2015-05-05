class SafeTableDropEventsPhotos < ActiveRecord::Migration
  def change
    drop_table :events_photos
  end
end
