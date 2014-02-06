class EventGiveaway < ActiveRecord::Base
    belongs_to :event
    belongs_to :giveaway

    validates_presence_of :event
    validates_presence_of :giveaway

    accepts_nested_attributes_for :giveaway, reject_if: :all_blank
end
