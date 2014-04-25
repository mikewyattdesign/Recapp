# This class produces API keys associated with a user for use in the
# API. All API calls to this application must include a valid API key
class ApiKey < ActiveRecord::Base
    belongs_to :user

    before_create :generate_access_token

    validates :name, presence: true
    validates :user, presence: true

    private

    # Generate a random access_token. Ensure that no other api_keys have
    # the same token. If a duplicate exists, try again.
    def generate_access_token
        loop do
            self.access_token = SecureRandom.hex
            break unless self.class.exists?(access_token: access_token)
        end
    end
end
