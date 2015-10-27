class Brand < ActiveRecord::Base
    include Approval

    has_many :programs
    has_many :events, through: :programs
    has_many :assignments, as: :assignable, dependent: :destroy
    has_many :users, through: :assignments
    has_attached_file :logo, styles: {large: '700x700', medium: '500x500', small: '300x300'}
    validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\z/

    validates :name, presence: true, uniqueness: true

    def photos(user = nil)
        event_ids = get_approved_events(self, user).pluck(:id)
        Photo.where(imageable_type: "Event", imageable_id: event_ids)
    end

    def favorite_photos(user = nil)
        # photos.where(brand_favorite: true) # Currently just favorite as event photos.
        photos(user).where(event_favorite: true)
    end
end
