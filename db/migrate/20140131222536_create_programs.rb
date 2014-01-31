class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.belongs_to :brand
      t.datetime :deactivated_at
      t.timestamps

    end
  end
end
