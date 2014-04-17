class AddStartingInventoryToGiveaways < ActiveRecord::Migration
  def change
    add_column :giveaways, :starting_inventory, :integer, default: 0
  end
end
