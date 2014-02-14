class AddDefaultRoleToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :role, :integer, default: 4
  end
end
