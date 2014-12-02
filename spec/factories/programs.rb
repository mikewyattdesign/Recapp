require 'faker'

FactoryGirl.define do
    factory :program do
        name { Faker::Company.catch_phrase }
        sequence(:id)
        sequence(:brand_id)

        brand
    end
end
