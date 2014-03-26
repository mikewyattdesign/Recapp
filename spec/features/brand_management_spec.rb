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
	context 'User alters existing brand' do
		before {@original_brand = create(:brand)}
		scenario 'User updates a brand' do
			visit edit_brand_path(@original_brand)
			fill_in 'Name', with: @brand.name
			click_button 'Update Brand'
			expect(current_path).to eq("/brands")
			expect(page).to have_content "#{@brand.name}"
		end
		scenario 'User deletes a brand' do
			visit brands_path
			expect(page).to have_css("[href='/brands/#{@original_brand.id}']")
			find("[href='/brands/#{@original_brand.id}'][data-method='delete']").click
			expect(current_path).to eq("/brands")
			expect(page).to have_no_content "#{@original_brand.name}"
		end
	end
end