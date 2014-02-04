class AddTaggableToTags < ActiveRecord::Migration
  def change
    add_reference :tags, :taggable, polymorphic: true
  end
end
