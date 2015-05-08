class RenameEventsFavoritePhotosToEventFavoritePhotos < ActiveRecord::Migration
  def change
    rename_table :events_favorite_photos, :event_favorite_photos
  end
end
