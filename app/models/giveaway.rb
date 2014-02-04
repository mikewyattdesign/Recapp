class Giveaway < ActiveRecord::Base
    has_many :event_giveaways
    has_many :events, through: :event_giveaways
end
