require 'rails_helper'

describe Assignment do
    let(:user) { create(:user) }

    it 'is valid with a user_id, an assignable_id, and an assignable_type' do
        event = create(:event)
        a = Assignment.new(
            user_id: user.id,
            assignable_id: event.id,
            assignable_type: 'Event'
        )
        expect(a).to be_valid
    end

    it 'is invalid without a user' do
        expect do
            Assignment.create!(user_id: nil)
        end.to raise_error(
            ActiveRecord::RecordInvalid,
            /user can't be blank/i
        )
    end

    it 'is invalid without an assignable_type' do
        expect do
            Assignment.create!(assignable_type: nil)
        end.to raise_error(
            ActiveRecord::RecordInvalid,
            /assignable type can't be blank/i
        )
    end

    it 'is invalid without an assignable_id' do
        expect do
            Assignment.create!(assignable_id: nil)
        end.to raise_error(
            ActiveRecord::RecordInvalid,
            /assignable can't be blank/i
        )
    end

    it 'responds to user' do
        a = Assignment.new(
            user_id: user.id,
            assignable_id: user.id,
            assignable_type: 'Event'
        )
        expect(a).to respond_to(:user)
    end

    it 'responds with its user' do
        a = Assignment.create(
            user_id: user.id,
            assignable_id: user.id,
            assignable_type: 'Event'
        )
        expect(a.user).to eq(user)
    end
end
