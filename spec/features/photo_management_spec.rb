require 'rails_helper'

feature 'Photo Management' do
    before do
        @brand = create(:brand)
        @program = create(:program, brand_id: @brand.id)
        @event = create(:event, program_id: @program.id)
        @photo = create(:photo_on_event, imageable_id: @event.id, created_at: Date.new(2014, 11, 9), direct_upload_url: "http://placebear.com/200/300")
        FactoryGirl.create_list(:photo_on_event, 3, imageable_id: @event.id)
        @user = create(:user, role: 0)
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Login'
    end
    scenario 'User filters photos' do
        visit photos_path
        expect(page).to have_selector('.list-photo-container', count: 4)
        fill_in 'From:', with: '11/8/2014'
        fill_in 'To:', with: '11/10/2014'
        click_button 'Filter'
        expect(page).to have_selector('.list-photo-container', count: 1)
    end

end
