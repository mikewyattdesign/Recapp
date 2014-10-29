# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
    factory :assignment do
        user
        assignable { |a| a.association(:brand) }
    end
end
