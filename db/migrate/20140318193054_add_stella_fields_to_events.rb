class AddStellaFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :estimated_number_of_samples, :integer
    add_column :events, :cost_per_sample, :decimal
    add_column :events, :tier, :integer
  end
end
