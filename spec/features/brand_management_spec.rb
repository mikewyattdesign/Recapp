require 'spec_helper'

feature 'Brand Management' do
	before {@brand = build(:brand)}
	scenario 'User creates a brand' do
		visit brands_path
		click_link 'New Brand'
		fill_in 'Name', with: @brand.name
		click_button 'Create Brand'
		expect(current_path).to eq("/brands")
		expect(page).to have_content "#{@brand.name}"
	end
	scenario 'User updates a brand' do
		@original_brand = create(:brand)
		visit edit_brand_path(@original_brand)
		fill_in 'Name', with: @brand.name
		click_button 'Update Brand'
		expect(current_path).to eq("/brands")
		expect(page).to have_content "#{@brand.name}"
	end
end