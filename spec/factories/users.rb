require 'faker'

FactoryGirl.define do
	factory :user do
		email { Faker::Internet.email }
		password { Faker::Lorem.characters(8) }
		username { Faker::Name.first_name }
		sequence(:id)
		sequence(:role ) {|n| n % 4}
	end
end