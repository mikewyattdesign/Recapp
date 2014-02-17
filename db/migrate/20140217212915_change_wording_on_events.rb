class ChangeWordingOnEvents < ActiveRecord::Migration
  def change
  	rename_column :events, :footprint_attendance, :footprint_impressions
  	rename_column :events, :display_attendance, :walk_by_impressions
  	remove_column :events, :samples_given
  	add_column :event_giveaways, :wholesaler_or_local_support, :boolean, default: false
  end
end
