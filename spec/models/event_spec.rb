require 'rails_helper'

describe Event do
	before { @event = build(:event)}
	it "is valid with name, start_date_time, end_date_time, and program_id" do
		expect(build(:event)).to be_valid
	end
	it "is invalid without name" do
		expect {
			Event.create!(name: nil)
		}.to raise_error(ActiveRecord::RecordInvalid, /name can't be blank/i)
	end
	it "is invalid without start_date_time" do
		expect {
			Event.create!(start_date_time: nil)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/start date time can't be blank/i
		)
	end
	it "is invalid without end_date_time" do
		expect {
			Event.create!(end_date_time: nil)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/end date time can't be blank/i
		)
	end
	it "is invalid without program_id" do
		expect {
			Event.create!(program_id: nil)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/program can't be blank/i
		)
	end
	it "is invalid with start_date_time after end_date_time" do
		expect {
			Event.create!(
				start_date_time: Date.today,
				end_date_time: Date.yesterday
			)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/end date time comes before start date time/i
		)
	end
	it "responds to program" do
		expect(build(:event)).to respond_to(:program)
	end
	it "returns its program" do
		program = Program.create(name: 'Heroes', brand_id: 1)
		event = build(:event,
			program_id: program.id)
		expect(event.program).to eq program
	end
	it "responds to weather" do
		expect(@event).to respond_to(:weather)
	end
	it "responds to comments" do
		expect(@event).to respond_to(:comments)
	end
	it "responds to photos" do
		expect(@event).to respond_to(:photos)
	end
	it "responds to giveaways" do
		expect(@event).to respond_to(:giveaways)
	end
	it "responds to event_giveaways" do
		expect(@event).to respond_to(:event_giveaways)
	end
	it "responds to tags" do
		expect(@event).to respond_to(:tags)
	end
	it "responds to miles" do
		expect(@event).to respond_to(:miles)
	end
	it "responds to videos" do
		expect(@event).to respond_to(:videos)
	end

	it "calculates mileage impressions based on miles" do
		@event.miles = 1
		expect(@event.mileage_impressions).to eq(82)
	end
end
