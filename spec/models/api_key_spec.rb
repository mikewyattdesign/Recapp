require 'rails_helper'

describe ApiKey do
    subject { create :api_key }
    let(:user) { create :user }

    it { should respond_to(:name) }
    it { should respond_to(:access_token) }
    it { should respond_to(:user_id) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }

    it { should be_valid }

    it 'has an access_token string' do
        expect(subject.access_token).to be_present
    end

    it 'requires a name' do
        expect(ApiKey.new(user_id: user.id)).to_not be_valid
    end

    it 'requires a user_id' do
        expect(ApiKey.new(name: 'steven')).to_not be_valid
    end
end
