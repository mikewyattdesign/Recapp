class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer
    add_column :users, :username, :string
  end
end
