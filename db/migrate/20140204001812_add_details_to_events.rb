class AddDetailsToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :weather
  end
end
