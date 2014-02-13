require 'spec_helper'

describe Assignment do
	it "is valid with a user_id, an assignable_id, and an assignable_type" do
		u = User.create(email: 'Mike', password: '00000000', id: 1 )
		a = Assignment.new(user_id: 1, assignable_id: 1, assignable_type: "Event")
		expect(a).to be_valid
	end
	it "is invalid without a user" do
		a = Assignment.new(user_id: nil)
		expect(a).to have(1).errors_on(:user_id)
	end
	it "is invalid without an assignable_type" do
		a = Assignment.new(assignable_type: nil)
		expect(a).to have(1).errors_on(:assignable_type)
	end
	it "is invalid without an assignable_id" do
		a = Assignment.new(assignable_id: nil)
		expect(a).to have(1).errors_on(:assignable_id)
	end
	it "responds to user" do
		a = Assignment.new(user_id: 1, assignable_id: 1, assignable_type: "Event")
		expect(a).to respond_to(:user)
	end
	it "responds with its user" do
		u = User.create(email: 'mike@mikewyattdesign.com', password: '00000000', id: 1 )
		a = Assignment.create(user_id: u.id, assignable_id: 1, assignable_type: "Event")
		expect(a.user).to eq(u)
	end
end
