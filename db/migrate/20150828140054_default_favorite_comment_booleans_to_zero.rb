class DefaultFavoriteCommentBooleansToZero < ActiveRecord::Migration
  def change
    change_column_null :comments, :event_favorite, false, 0
    change_column_null :comments, :program_favorite, false, 0
    change_column_null :comments, :brand_favorite, false, 0
    change_column_default :comments, :event_favorite, false
    change_column_default :comments, :program_favorite, false
    change_column_default :comments, :brand_favorite, false
  end
end
