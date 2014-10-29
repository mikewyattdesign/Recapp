require 'spec_helper'

describe Program do
	it "is valid with a name, and brand_id" do
		brand = create(:brand)
		program = Program.new(name: 'Heroes', brand_id: brand.id)
		expect(program).to be_valid
	end
	it "is invalid without a name" do
		expect {
			Program.create!(name: nil)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/name can't be blank/i
		)
	end
	it "is invalid without a brand_id" do
		expect {
			Program.create!(brand_id: nil)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/brand can't be blank/i
		)
	end
	it "responds to brand" do
		brand = create(:brand)
		expect(Program.new(name: 'Heroes', brand_id: brand.id)).to respond_to(:brand)
	end
	it "returns its brand" do
		busch = create(:brand)
		program = Program.new(name: 'Heroes', brand_id: busch.id)
		expect(program.brand).to eq busch
	end
	it "responds to events" do
		brand = create(:brand)
		expect(Program.new(name: 'Heroes', brand_id: brand.id)).to respond_to(:events)
	end
end
