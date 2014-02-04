class Event < ActiveRecord::Base
    belongs_to :program
    has_one :location
    has_many :comments
    has_many :photos, as: :imageable
    has_many :event_giveaways
    has_many :giveaways, through: :event_giveaways
    has_one :weather
    has_many :tags, as: :taggable
end
