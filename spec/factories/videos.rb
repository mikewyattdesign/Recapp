include ActionDispatch::TestProcess

FactoryGirl.define do
    factory :video do
        media do
            fixture_file_upload(
                Rails.root.join('spec', 'support', '01_LoggingIn.mov'),
                'video/quicktime'
            )
        end
        event
    end
end
