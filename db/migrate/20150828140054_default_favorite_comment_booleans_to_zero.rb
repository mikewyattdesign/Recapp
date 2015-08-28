class DefaultFavoriteCommentBooleansToZero < ActiveRecord::Migration
  def change
    change_column_null :comments, :event_favorite, false, 0
    change_column_null :comments, :program_favorite, false, 0
    change_column_null :comments, :brand_favorite, false, 0
    if  Rails.env.production?
        change_column :comments, :event_favorite, 'boolean USING CAST(event_favorite as boolean)', default: 0
        change_column :comments, :program_favorite, 'boolean USING CAST(program_favorite as boolean)', default: 0
        change_column :comments, :brand_favorite, 'boolean USING CAST(brand_favorite as boolean)', default: 0
    else
        change_column :comments, :event_favorite, :boolean, default: 0
        change_column :comments, :program_favorite, :boolean, default: 0
        change_column :comments, :brand_favorite, :boolean, default: 0
    end
  end
end
