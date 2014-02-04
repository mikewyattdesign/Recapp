class CreateEventGiveaways < ActiveRecord::Migration
  def change
    create_table :event_giveaways do |t|

      t.timestamps
    end
  end
end
