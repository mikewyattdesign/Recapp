class Photo < ActiveRecord::Base
    # TODO: Add paperclip relationships and validation
    has_attached_file :image
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

    belongs_to :imageable, polymorphic: true
    has_many :tags, as: :taggable

    def event
    	Event.find(imageable_id) if imageable_type == Event.name
    end
end
