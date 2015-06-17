class Brand < ActiveRecord::Base
    has_many :programs
    has_many :assignments, as: :assignable, dependent: :destroy
    has_many :users, through: :assignments
    has_attached_file :logo, styles: {large: '700x700', medium: '500x500', small: '300x300'}
    validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\z/

    validates :name, presence: true, uniqueness: true

    def events
    	program_ids = programs.pluck(:id)
    	Event.where(program_id: program_ids)
    end

    def photos
        event_ids = events.pluck(:id)
        Photo.where(imageable_type: "Event", imageable_id: event_ids)
    end

    def favorite_photos
        # photos.where(brand_favorite: true) # Currently just favorite as event photos.
        photos.where(event_favorite: true)
    end
end
