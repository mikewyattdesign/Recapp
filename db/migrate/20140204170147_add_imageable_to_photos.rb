class AddImageableToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :imeageable, polymorphic: true
  end
end
