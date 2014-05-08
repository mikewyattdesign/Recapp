# Photos should by default not be marked as 'processed'
class SetPhotoProcessedDefaultToFalse < ActiveRecord::Migration
  def change
    change_column :photos, :processed, :boolean, default: false, null: false
  end
end
