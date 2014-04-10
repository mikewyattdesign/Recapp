class Photo < ActiveRecord::Base
    # TODO: Add paperclip relationships and validation
    has_attached_file :image, styles: {large: '700x700', medium: '500x500', small: '300x300'}
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

    belongs_to :imageable, polymorphic: true
    acts_as_taggable

    def self.with_event
    	Photo.where(id: (Photo.where(imageable_type: 'Event').reject{|p| p.event.nil?}.map{|p|p.id}))
    end

    def event
    	if imageable_type == Event.name 
    		Event.find(imageable_id) if Event.where(id: imageable_id).count > 0
    	end
    end

    def event_id
        event.id if event.present?
    end

    def program_id
        event.program.id if event.present?
    end

    def brand_id
        event.program.brand_id if event.present?
    end

    def image_url
        image.url if image.present?
    end
end
