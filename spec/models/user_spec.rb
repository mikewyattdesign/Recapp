require 'spec_helper'

describe User do
	it "responds to events" do 
		expect(build(:user)).to respond_to(:events)
	end
	it "responds to programs" do
		expect(build(:user)).to respond_to(:programs)
	end
	it "responds to brands" do
		expect(build(:user)).to respond_to(:brands)
	end
end
