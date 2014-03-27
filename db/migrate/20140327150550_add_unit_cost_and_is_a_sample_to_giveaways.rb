class AddUnitCostAndIsASampleToGiveaways < ActiveRecord::Migration
  def change
    add_column :giveaways, :unit_cost, :decimal, default: 0
    add_column :giveaways, :is_a_sample, :boolean, default: false
    add_column :giveaways, :samples_per_unit, :integer, default: 0
  end
end
