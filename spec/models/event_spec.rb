require 'spec_helper'

describe Event do
	it "is valid with name, start_date_time, end_date_time, and program_id" do
		expect(build(:event)).to be_valid
	end
	it "is invalid without name" do 
		expect(build(:event, name: nil)).to have(1).errors_on(:name)
	end
	it "is invalid without start_date_time" do
		expect(build(:event, start_date_time: nil)).to have(1).errors_on(:start_date_time)
	end
	it "is invalid without end_date_time" do
		expect(build(:event, end_date_time: nil)).to have(1).errors_on(:end_date_time)
	end
	it "is invalid without program_id" do
		expect(build(:event, program_id: nil)).to have(1).errors_on(:program_id)
	end
	it "is invalid with start_date_time after end_date_time" do
		event = build(:event,
			start_date_time: Date.today,
			end_date_time: Date.yesterday)
		expect(event).to have(1).errors_on(:end_date_time)
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
		event = build(:event)
		expect(event).to respond_to(:weather)
	end
	it "responds to comments" do
		event = build(:event)
		expect(event).to respond_to(:comments)
	end
	it "responds to photos" do
		event = build(:event)
		expect(event).to respond_to(:photos)
	end
	it "responds to giveaways" do
		event = build(:event)
		expect(event).to respond_to(:giveaways)
	end
	it "responds to event_giveaways" do
		event = build(:event)
		expect(event).to respond_to(:event_giveaways)
	end
	it "responds to tags" do
		event = build(:event)
		expect(event).to respond_to(:tags)
	end
	it "responds to miles" do
		event = build(:event)
		expect(event).to respond_to(:miles)
	end

	it "calculates mileage impressions based on miles" do
		event = build(:event)
		event.miles = 1
		expect(event.mileage_impressions).to eq(82)
	end
end
