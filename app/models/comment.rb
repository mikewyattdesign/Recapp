class Comment < ActiveRecord::Base
    belongs_to :event, inverse_of: :comments
end
