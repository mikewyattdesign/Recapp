require 'faker'

FactoryGirl.define do
    factory :comment do
        content { Faker::Company.bs }
    end
end