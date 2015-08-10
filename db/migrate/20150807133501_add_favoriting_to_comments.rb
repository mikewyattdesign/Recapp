class AddFavoritingToComments < ActiveRecord::Migration
  def change
    add_column :comments, :event_favorite, :integer
    add_column :comments, :program_favorite, :integer
    add_column :comments, :brand_favorite, :integer
  end
end
