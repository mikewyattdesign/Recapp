FactoryGirl.define do
    factory :photo do
        image File.new("#{Dir.pwd}/spec/support/IMG_5024.jpg")

        factory :photo_on_event do
            imageable_id { create(:event).id }
            imageable_type 'Event'
        end
    end
end
