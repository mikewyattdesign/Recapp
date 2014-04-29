require 'faker'

FactoryGirl.define do
    factory :api_key do
        name { Faker::Name.name }
        user
    end
end
