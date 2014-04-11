class AddEventIdToVideos < ActiveRecord::Migration
  def change
    add_reference :videos, :event, index: true
  end
end
