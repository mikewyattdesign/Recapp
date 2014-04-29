class AddEventOverviewAndKpIsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :overview, :text
    add_column :events, :kpis, :string
  end
end
