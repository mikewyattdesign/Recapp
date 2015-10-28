class AddApprovedToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :approved, :boolean, default: false
  end
end
