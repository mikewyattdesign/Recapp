require 'spec_helper'

feature 'Brand Management' do
	scenario 'User creates a brand' do
		@brand = build(:brand)
		visit brands_path
		click_link 'New Brand'
		fill_in 'Name', with: @brand.name
		click_button 'Create Brand'
		expect(current_path).to eq("/brands")
		expect(page).to have_content "#{@brand.name}"
	end
end