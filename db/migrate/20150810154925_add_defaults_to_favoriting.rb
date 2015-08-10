class AddDefaultsToFavoriting < ActiveRecord::Migration
  def change
    change_column :comments, :event_favorite, :integer, default: 0
    change_column :event_giveaways, :event_favorite, :integer, default: 0
  end
end
