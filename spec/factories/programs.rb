require 'faker'

FactoryGirl.define do
    factory :program do
        name { Faker::Company.catch_phrase }
        sequence(:id)
        sequence(:brand_id)
        overview { Faker::Lorem.sentence }
        brand
    end
end
