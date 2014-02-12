require 'spec_helper'

describe Brand do
	it "is valid with a name" do
		brand = Brand.new(name: 'Busch')
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
	it "responds to it's programs" do
		expect(Brand.new(name: 'Busch')).to respond_to(:programs)
	end
end
