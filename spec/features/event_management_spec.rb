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
		scenario 'User edits an event\'s name and times' do
			visit edit_event_path(@original_event)
			fill_in 'Name', with: @event.name
			expect(find_field('Program').value).to eq @program.id.to_s
			fill_in 'Name', with: @event.name
			fill_in 'Start Date', with: @event.start_date
			fill_in 'End Date', with: @event.end_date
			fill_in 'Start Time', with: @event.start_time
			fill_in 'End Time', with: @event.end_time
			click_button 'Update Event'
			expect(page).to have_content @event.name
		end
		scenario 'User edits an event\'s location' do
			visit edit_event_path(@original_event)
			fill_in 'Street', with: @event.street
			fill_in 'City', with: @event.city
			fill_in 'State', with: @event.state
			fill_in 'Postal Code', with: @event.postal_code
			fill_in 'Country', with: @event.country
			click_button 'Update Event'
			expect(page).to have_content @event.city
			expect(page).to have_content @event.state
		end
		scenario 'User edits an event\'s impression and stats' do
			visit edit_event_path(@original_event)
			total_attendance = Random.new.rand(100..3000)
			miles_traveled = Random.new.rand(50..500)
			fill_in 'Total Event Attendance', with: total_attendance
			fill_in 'Miles Traveled from Last Event', with: miles_traveled
			fill_in 'Walk By Impressions', with: total_attendance*2/3
			fill_in 'Footprint Impressions', with: total_attendance/3
			fill_in 'Extended Engagements', with: total_attendance/6
			fill_in 'Digital Engagements', with: 0
			click_button 'Update Event'
			visit edit_event_path(@original_event.id)
			expect(find_field('Total Event Attendance').value).to eq total_attendance.to_s
			expect(find_field('Miles Traveled from Last Event').value).to eq miles_traveled.to_s
			expect(find_field('Walk By Impressions').value).to eq (total_attendance*2/3).to_s
			expect(find_field('Footprint Impressions').value).to eq (total_attendance/3).to_s
			expect(find_field('Extended Engagements').value).to eq (total_attendance/6).to_s
			expect(find_field('Digital Engagements').value).to eq '0'
		end
		scenario 'User deletes an event' do
			visit program_events_path(@program)
			expect(page).to have_css("[href='/events/#{@original_event.id}']")
			find("[href='/events/#{@original_event.id}'][data-method='delete']").click
			expect(current_path).to eq events_path
			expect(page).to have_no_css "[data-event-id='#{@original_event.id}'][data-method='delete']"
		end
	end
	scenario 'User views an event recap' do
		@new_event = create(:event, program_id: @program.id)
		visit program_events_path(@program)
		expect(page).to have_css("[href='/events/#{@new_event.id}']")
		click_link @new_event.name
		expect(current_path).to eq event_path(@new_event)
		expect(page).to have_content @new_event.name
	end
end