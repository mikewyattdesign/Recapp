require 'spec_helper'

feature 'Event Management' do
	before {
		@brand = create(:brand)
		@program = create(:program, brand_id: @brand.id)
		@event = build(:event)
	}
	scenario 'User creates an event' do
		visit program_events_path(@program)
		click_link 'New Event'
		fill_in 'Name', with: @event.name
		expect(find_field('Program').value).to eq @program.id.to_s
		fill_in 'Name', with: @event.name
		fill_in 'Start Date', with: @event.start_date
		fill_in 'End Date', with: @event.end_date
		fill_in 'Start Time', with: @event.start_time
		fill_in 'End Time', with: @event.end_time
		fill_in 'Street', with: @event.street
		fill_in 'City', with: @event.city
		fill_in 'State', with: @event.state
		fill_in 'Postal Code', with: @event.postal_code
		fill_in 'Country', with: @event.country
		click_button 'Create Event'
		expect(page).to have_content @event.name
		expect(page).to have_content @event.city
		expect(page).to have_content @event.state
	end
	context 'User alters existing Event' do
		before { @original_event = create(:event, program_id: @program.id)}
	end
end