class Photo < ActiveRecord::Base
    # TODO: Add paperclip relationships and validation
    has_attached_file :photo
    validates_atachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

    belongs_to :imageable, polymorphic: true
    has_many :tags, as: :taggable
end
