require 'spec_helper'

describe Brand do
	it "is valid with a name" do
		brand = build(:brand)
		expect(brand).to be_valid
	end
	it "is invalid without a name" do
		expect(Brand.new(name: nil)).to have(1).errors_on(:name)
	end
	it "is invalid with a duplicate name" do 
		Brand.create(name: 'Busch')
		brand = Brand.new(name: 'Busch')
		expect(brand).to have(1).errors_on(:name)
	end
	it "responds to programs" do
		expect(Brand.new(name: 'Busch')).to respond_to(:programs)
	end
	it "responds to events" do 
		expect(build(:brand)).to respond_to(:events)
	end

	it "returns its programs" do
		brand = create(:brand)
		p1 = create(:program, brand_id: brand.id)
		expect(brand.programs).to include p1
	end
	it "returns only its programs" do
		brand = create(:brand)
		p1 = create(:program, brand_id: brand.id)
		p2 = create(:program, brand_id: brand.id + 1)
		expect(brand.programs).to_not include p2
	end
	it "returns its events" do
		brand = create(:brand)
		p1 = create(:program, brand_id: brand.id)
		e1 = create(:event, program_id: p1.id)
		expect(brand.events).to include e1
	end
	it "returns only its events" do
		brand = create(:brand)
		p1 = create(:program, brand_id: brand.id)
		e1 = create(:event, program_id: p1.id)
		e2 = create(:event, program_id: p1.id)
		e3 = create(:event, program_id: p1.id + 1)
		expect(brand.events).to_not include e3
	end
end
