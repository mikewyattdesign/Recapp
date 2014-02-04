class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :digital_engagements, :integer, default: 0
    add_column :events, :mileage_impressions, :integer, default: 0
    add_column :events, :footprint_attendance, :integer
    add_column :events, :display_attendance, :integer
    add_column :events, :total_attendance, :integer
    add_column :events, :estimated_total_impressions, :integer
  end
end
