class Event < ActiveRecord::Base
    belongs_to :program
    belongs_to :location
    has_many :comments
    has_many :photos, as: :imageable
    has_many :event_giveaways, inverse_of: :event
    has_many :giveaways, through: :event_giveaways
    has_one :weather
    has_many :tags, as: :taggable

    accepts_nested_attributes_for :event_giveaways
    accepts_nested_attributes_for :giveaways
    accepts_nested_attributes_for :weather
    accepts_nested_attributes_for :location
end
