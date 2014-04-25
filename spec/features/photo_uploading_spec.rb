require 'spec_helper'

feature 'Photo Uploading' do
	scenario 'User Uploads a photo to an event' do
		@brand = create(:brand)
		@program = create(:program, brand_id: @brand.id)
		@event = create(:event, program_id: @program.id)
		
		@user = create(:user, role: 0)
		visit new_user_session_path
		fill_in 'Email', with: @user.email
		fill_in 'Password', with: @user.password
		click_button 'Login'

		visit edit_event_path(@event)
		click_on 'Manage Event Photos'
		expect(current_path).to eq event_photos_path(@event)

		click_on 'New Photo'
		attach_file 'photo_image', "#{Dir.pwd}/spec/support/IMG_5024.jpg"
		click_on 'Create Photo'

		expect(current_path).to eq event_photos_path(@event)
		expect(page).to have_css "[src='#{@event.photos.last.image(:small)}']"

	end
end