class AddFavoritingToEventGiveaways < ActiveRecord::Migration
  def change
    add_column :event_giveaways, :event_favorite, :integer
  end
end
