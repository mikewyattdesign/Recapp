class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.integer :location_id
      t.integer :program_id
      t.boolean :brand_demo_fit
      t.integer :samples_given

      t.timestamps
    end
  end
end
