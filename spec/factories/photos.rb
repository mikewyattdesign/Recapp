FactoryGirl.define do
    factory :photo do
        image File.new("#{Dir.pwd}/spec/support/IMG_5024.jpg")

        created_at Date.today

        after(:build) do |user|
            user.class.skip_callback(:create, :after, :queue_processing)
        end

        factory :photo_on_event do
            imageable_id { create(:event).id }
            imageable_type 'Event'
        end
    end
end
