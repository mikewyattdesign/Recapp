require 'faker'

FactoryGirl.define do
	factory :user do
		email { Faker::Internet.email }
		password { Faker::Lorem.characters(8) }
		username { Faker::Name.first_name }
		sequence(:id)
	end
end