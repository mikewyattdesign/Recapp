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

        # TODO: Testing this has become impossible.  For some reason,
        # I can't get Capybara and selenium to cooperate with file
        # attachment.  I tried looking into adjusting the file_detector
        # to no avail.
        # http://sauceio.com/index.php/2013/12/remote-file-uploads-with-selenium-capybara/
        # Eventually, I'd like to be able to test this feature again.
    end
end
