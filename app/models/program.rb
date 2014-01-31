class Program < ActiveRecord::Base
    has_many :events
    belongs_to :brand
end
