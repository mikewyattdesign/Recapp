require 'faker'

FactoryGirl.define do
    factory :user do
        email { Faker::Internet.email }
        password { Faker::Internet.password }
        username { Faker::Name.first_name }
        sequence(:id)
        sequence(:role) { |n| n % 4 }
    end
end
