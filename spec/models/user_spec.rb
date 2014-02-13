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
	it "can be assigned to a brand" do
		u = create(:user)
		b = create(:brand)
		u.assign_to_brand(b)
		expect(u.brands).to include b
	end

	it "can be assigned to a program" do
		u = create(:user)
		p = create(:program)
		u.assign_to_program(p)
		expect(u.programs).to include p
	end

	it "returns events for the programs it's assigned to" do
		u = create(:user)
		p = create(:program)
		e1 = create(:event, program_id: p.id)
		u.assign_to_program(p)
		expect(u.events).to include e1
	end

	it "returns events for the brands it's assigned to" do
		u = create(:user)
		b = create(:brand)
		p = create(:program, brand_id: b.id)
		e2 = create(:event, program_id: p.id)
		u.assign_to_brand(b)
		expect(u.events).to include e2
	end

	it "returns events for programs added to its assigned brand regardless of creation time" do
		u = create(:user)
		brand = create(:brand)
		u.assign_to_brand(brand)
		program = create(:program, brand_id: brand.id)
		e2 = create(:event, program_id: program.id)
		expect(u.events).to include e2
	end
	it "returns events for the combination of programs and brands it's assigned to" do
		u = create(:user)
		brand1 = create(:brand)
		brand2 = create(:brand)
		u.assign_to_brand(brand1)
		program1 = create(:program, brand_id: brand1.id)
		program2 = create(:program, brand_id: brand2.id)
		e3 = create(:event, program_id: program1.id)
		e4 = create(:event, program_id: program2.id)
		u.assign_to_program(program2)
		expect(u.events).to include e3
		expect(u.events).to include e4
	end
	it "can be removed from a program" do
		u = create(:user)
		brand1 = create(:brand)
		brand2 = create(:brand)
		program1 = create(:program, brand_id: brand1.id)
		program2 = create(:program, brand_id: brand2.id)
		u.assign_to_program(program1)
		u.assign_to_program(program2)
		u.remove_from_program(program1)
		expect(u.programs).to_not include program1
	end
	it "can be removed from a brand" do
		# u = create(:user)
		# brand1 = create(:brand)
		# brand2 = create(:brand)
		# u.assign_to_brand(brand1)
		# u.assign_to_brand(brand2)
		# u.remove_from_brand(brand1)
		# expect(u.brands).to_not include brand1
	end

end
