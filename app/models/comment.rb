class Comment < ActiveRecord::Base
    belongs_to :event, inverse_of: :comments

    validates :event_id, presence: true
end
