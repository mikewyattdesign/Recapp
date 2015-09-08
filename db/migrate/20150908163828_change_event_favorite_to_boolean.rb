class ChangeEventFavoriteToBoolean < ActiveRecord::Migration
  def change
    change_column :comments, :event_favorite, :boolean, default: 0
    change_column :comments, :program_favorite, :boolean, default: 0
    change_column :comments, :brand_favorite, :boolean, default: 0
  end
end
