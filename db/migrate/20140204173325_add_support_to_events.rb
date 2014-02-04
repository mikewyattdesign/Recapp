class AddSupportToEvents < ActiveRecord::Migration
  def change
    add_column :events, :wholesaler_or_local_support, :boolean
  end
end
