require 'rails_helper'

describe Assignment do
	it "is valid with a user_id, an assignable_id, and an assignable_type" do
		user = create(:user)
		event = create(:event)
		a = Assignment.new(user_id: user.id, assignable_id: event.id, assignable_type: "Event")
		expect(a).to be_valid
	end
	it "is invalid without a user" do
		expect {
			Assignment.create!(user_id: nil)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/user can't be blank/i
		)
	end
	it "is invalid without an assignable_type" do
		expect {
			Assignment.create!(assignable_type: nil)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/assignable type can't be blank/i
		)
	end
	it "is invalid without an assignable_id" do
		expect {
			Assignment.create!(assignable_id: nil)
		}.to raise_error(
			ActiveRecord::RecordInvalid,
			/assignable can't be blank/i
		)
	end
	it "responds to user" do
		u = User.create(email: 'Mike', password: '00000000')
		a = Assignment.new(user_id: u.id, assignable_id: u.id, assignable_type: "Event")
		expect(a).to respond_to(:user)
	end
	it "responds with its user" do
		u = User.create(email: 'mike@mikewyattdesign.com', password: '00000000')
		a = Assignment.create(user_id: u.id, assignable_id: u.id, assignable_type: "Event")
		expect(a.user).to eq(u)
	end
end
