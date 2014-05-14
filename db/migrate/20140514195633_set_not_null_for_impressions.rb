# Attendance statistics for events should not allow null values.
class SetNotNullForImpressions < ActiveRecord::Migration
    @@statistics = %i(
        digital_engagements
        mileage_impressions
        footprint_impressions
        walk_by_impressions
        total_attendance
        extended_engagements
    )

    def up
        @@statistics.each do |statistic|
            Event.where(statistic => nil).update_all(statistic => 0)
            change_column :events, statistic, :integer, default: 0, null: false
        end
    end

    def down
        @@statistics.each do |statistic|
            change_column :events, statistic, :integer, default: 0, null: true
        end
    end
end
