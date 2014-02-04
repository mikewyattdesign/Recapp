class Event < ActiveRecord::Base
    has_one :location
    has_many :comments
    has_many :photos, as: :imageable
end
