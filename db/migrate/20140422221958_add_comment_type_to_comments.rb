class AddCommentTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_type, :integer, default: 1
  end
end
