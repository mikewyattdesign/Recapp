class AddOverviewToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :overview, :text
  end
end
