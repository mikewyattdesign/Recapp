class EventGiveaway < ActiveRecord::Base
    belongs_to :event
    belongs_to :giveaway
end
