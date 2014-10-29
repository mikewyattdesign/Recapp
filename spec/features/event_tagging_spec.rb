require 'rails_helper'

feature 'Event Tagging' do
    before {
        @brand = create(:brand)
        @program = create(:program, brand_id: @brand.id)
        @event = create(:event, program_id: @program.id)
        @tag_array = ["super", "cali", "fragilistic", "expia lidocious"]
        @user = create(:user, role: 0)
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Login'
    }

    scenario "An event's tags are displayed on the event index" do
        @event.tag_list = @tag_array.join(',')
        @event.save
        @event.reload
        expect(@event.tag_list).to include @tag_array.first
        visit events_path
        within "[data-event-id='#{@event.id}']" do
            @tag_array.each do |tag|
                expect(page).to have_content tag
            end
        end
    end
end
