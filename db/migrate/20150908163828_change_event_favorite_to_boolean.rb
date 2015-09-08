class ChangeEventFavoriteToBoolean < ActiveRecord::Migration
  def up
    if Rails.env.staging? or Rails.env.production?
        rename_column :comments, :event_favorite, :event_favorite_temp
        rename_column :comments, :program_favorite, :program_favorite_temp
        rename_column :comments, :brand_favorite, :brand_favorite_temp
        add_column :comments, :event_favorite, :boolean, default: false
        add_column :comments, :program_favorite, :boolean, default: false
        add_column :comments, :brand_favorite, :boolean, default: false

        Comment.all.each do |c|
            c.event_favorite = c.event_favorite_temp > 0
            c.program_favorite = c.program_favorite_temp > 0
            c.brand_favorite = c.brand_favorite_temp > 0
        end

        remove_column :comments, :event_favorite_temp
        remove_column :comments, :program_favorite_temp
        remove_column :comments, :brand_favorite_temp
    else
        change_column :comments, :event_favorite, :boolean, default: 0
        change_column :comments, :program_favorite, :boolean, default: 0
        change_column :comments, :brand_favorite, :boolean, default: 0
    end
  end

  def down
    if Rails.env.staging? or Rails.env.production?
        add_column :comments, :event_favorite_temp, :integer, default: 0
        add_column :comments, :program_favorite_temp, :integer, default: 0
        add_column :comments, :brand_favorite_temp, :integer, default: 0

        Comment.all.each do |c|
            c.event_favorite_temp = c.event_favorite ? 1 : 0
            c.program_favorite_temp = c.program_favorite ? 1 : 0
            c.brand_favorite_temp = c.brand_favorite ? 1 : 0
        end

        remove_column :comments, :event_favorite
        remove_column :comments, :program_favorite
        remove_column :comments, :brand_favorite
        rename_column :comments, :event_favorite_temp, :event_favorite
        rename_column :comments, :program_favorite_temp, :program_favorite
        rename_column :comments, :brand_favorite_temp, :brand_favorite
    else
        change_column :comments, :event_favorite, :integer, default: 0
        change_column :comments, :program_favorite, :integer, default: 0
        change_column :comments, :brand_favorite, :integer, default: 0
    end
  end
end
