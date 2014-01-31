class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.datetime :deactivated_at
      t.timestamps
    end
  end
end
