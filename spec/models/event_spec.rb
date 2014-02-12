require 'spec_helper'

describe Event do
	it "is valid with name, start_date_time, end_date_time, and program_id" do
		event = Event.new(
			name: 'STL Heroes',
			start_date_time: Date.yesterday,
			end_date_time: Date.today,
			program_id: 1)
		expect(event).to be_valid
	end
	it "is invalid without name" do 
		expect(Event.new(name: nil)).to have(1).errors_on(:name)
	end
	it "is invalid without start_date_time" do
		expect(Event.new(start_date_time: nil)).to have(1).errors_on(:start_date_time)
	end
	it "is invalid without end_date_time" do
		expect(Event.new(end_date_time: nil)).to have(1).errors_on(:end_date_time)
	end
	it "is invalid without program_id" do
		expect(Event.new(program_id: nil)).to have(1).errors_on(:program_id)
	end
	it "is invalid with start_date_time after end_date_time" do
		event = Event.new(
			start_date_time: Date.today,
			end_date_time: Date.yesterday)
	end
	it "responds to program"
	it "returns its program"
	it "responds to weather"
	it "responds to comments"
	it "responds to photos"
	it "responds to giveaways"
	it "responds to event_giveaways"
	it "responds to tags"
end
