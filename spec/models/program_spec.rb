require 'spec_helper'

describe Program do
	it "is valid with a name, and brand_id" do
		program = Program.new(name: 'Heroes', brand_id: 1)
		expect(program).to be_valid
	end
	it "is invalid without a name" do
		expect(Program.new(name: nil)).to have(1).errors_on(:name)
	end
	it "is invalid without a brand_id" do
		expect(Program.new(brand_id: nil)).to have(1).errors_on(:brand_id)
	end
	it "responds to brand" do
		expect(Program.new(name: 'Heroes', brand_id: 1)).to respond_to(:brand)
	end
	it "returns its brand" do
		busch = create(:brand)
		program = Program.new(name: 'Heroes', brand_id: busch.id)
		expect(program.brand).to eq busch
	end
	it "responds to events" do
		expect(Program.new(name: 'Heroes', brand_id: 1)).to respond_to(:events)
	end
end
