class ChangeStellaNumberFieldToInteger < ActiveRecord::Migration
  def change
  	change_column :events, :estimated_number_of_samples, :integer 
  end
end
