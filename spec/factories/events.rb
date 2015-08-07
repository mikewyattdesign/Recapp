require 'faker'

FactoryGirl.define do
    factory :event do
        name { Faker::Company.bs }
        start_date_time Date.yesterday
        end_date_time Date.today
        program_id 1
        street { Faker::Address.street_address }
        city { Faker::Address.city }
        state { Faker::Address.state_abbr }
        postal_code { Faker::Address.zip_code[0..4] } # force to 5 digits
        venue { Faker::Company.name }
    end
end
