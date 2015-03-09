class AddFavoritesToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :event_favorite, :boolean, default: false
    add_column :photos, :program_favorite, :boolean, default: false
    add_column :photos, :brand_favorite, :boolean, default: false
  end
end
