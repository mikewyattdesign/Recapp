class CreateTableEventGiveaways < ActiveRecord::Migration
  def change
    create_table :event_giveaways do |t|
      t.references :event
      t.references :giveaway
      t.integer :count_given_away
    end
  end
end
