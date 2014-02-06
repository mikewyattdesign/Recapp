class AddAttachmentImageToGiveaways < ActiveRecord::Migration
  def self.up
    change_table :giveaways do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :giveaways, :image
  end
end
