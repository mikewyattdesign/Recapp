class AddDirectProcessingToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :processed, :boolean, default: false, null: false
    add_column :photos, :direct_upload_url, :string
    add_index :photos, :imageable_id
    add_index :photos, :imageable_type
    add_index :photos, :processed
  end
end
