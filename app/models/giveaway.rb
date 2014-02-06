class Giveaway < ActiveRecord::Base
    has_many :event_giveaways
    has_many :events, through: :event_giveaways
    has_attached_file :image
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
