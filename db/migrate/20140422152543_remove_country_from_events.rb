class RemoveCountryFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :country, :string
  end
end
