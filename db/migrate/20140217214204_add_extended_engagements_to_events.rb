class AddExtendedEngagementsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :extended_engagements, :integer
  end
end
