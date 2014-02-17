class RemoveEstimatedTotalImpressionsFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :estimated_total_impressions
  end
end
