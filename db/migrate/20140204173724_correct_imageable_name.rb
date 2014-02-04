class CorrectImageableName < ActiveRecord::Migration
  def change
    rename_column :photos, :imeageable_id, :imageable_id
    rename_column :photos, :imeageable_type, :imageable_type
  end
end
