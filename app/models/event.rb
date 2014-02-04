class Event < ActiveRecord::Base
    has_one :location
    has_many :comments
end
