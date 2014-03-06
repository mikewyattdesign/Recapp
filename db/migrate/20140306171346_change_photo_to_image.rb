class ChangePhotoToImage < ActiveRecord::Migration
  def change
  	drop_attached_file :photos, :photo
  end
end
