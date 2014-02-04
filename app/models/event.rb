class Event < ActiveRecord::Base
    has_one :location
    has_many :comments
    has_many :photos, as: :imageable
    has_many :event_giveaways
    has_many :giveaways, through: :event_giveaways
end
