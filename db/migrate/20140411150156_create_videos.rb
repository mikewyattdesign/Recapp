class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.attachment :media
      t.timestamps
    end
  end
end
