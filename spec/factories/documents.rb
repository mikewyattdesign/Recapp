include ActionDispatch::TestProcess

FactoryGirl.define do
    factory :document do
        doc do
            fixture_file_upload(
                Rails.root.join('spec', 'support', 'test.docx'),
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            )
        end
        documentable { |d| d.association :brand }
    end
end
