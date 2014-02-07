class AddDefaultsToEvents < ActiveRecord::Migration
  def change
    change_column :events, :samples_given, :integer, default: 0
    change_column :events, :footprint_attendance, :integer, default: 0
    change_column :events, :display_attendance, :integer, default: 0
    change_column :events, :total_attendance, :integer, default: 0
    change_column :events, :estimated_total_impressions, :integer, default: 0
  end
end
