class AddDefaultToExtendedEngagementsInEvents < ActiveRecord::Migration
  def change
  	change_column :events, :extended_engagements, :integer, default: 0
  end
end
