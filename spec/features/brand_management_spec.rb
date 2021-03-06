require 'rails_helper'

feature 'Brand Management' do
    let(:brand) { create(:brand) }
    let(:user) { create(:user, role: 0) }

    before do
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Login'
    end

    scenario 'User creates a brand' do
        new_name = Faker::Company.name
        visit brands_path
        click_on 'New Brand'
        expect(current_path).to eq('/brands/new')
        fill_in 'Name', with: new_name
        click_on 'Create Brand'
        expect(current_path).to eq('/brands')
        expect(page).to have_content "#{new_name}"
    end

    context 'User alters existing brand' do
        let!(:original_brand) { create(:brand) }

        scenario 'User updates a brand' do
            new_name = Faker::Company.name
            visit edit_brand_path(original_brand)
            fill_in 'Name', with: new_name
            click_on 'Update Brand'
            expect(current_path).to eq('/brands')
            expect(page).to have_content "#{new_name}"
        end

        scenario 'User deletes a brand' do
            visit brands_path
            expect(page).to have_css("[href='/brands/#{original_brand.id}']")
            find("[href='/brands/#{original_brand.id}'][data-method='delete']").click
            expect(current_path).to eq('/brands')
            expect(page).to have_no_content "#{original_brand.name}"
        end
    end
end
