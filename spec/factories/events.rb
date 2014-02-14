require 'faker'

FactoryGirl.define do
	factory :event do
		name { Faker::Company.bs }
		start_date_time Date.yesterday
		end_date_time Date.today
		program_id 1
	end
end