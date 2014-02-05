class AddLogoToBrands < ActiveRecord::Migration
  def change
    add_attachment :brands, :logo
  end
end
