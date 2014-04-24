class AddSuiteToEvents < ActiveRecord::Migration
  def change
    add_column :events, :suite, :string
  end
end
