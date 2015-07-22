class Program < ActiveRecord::Base
    has_many :events, -> {order('"events"."start_date_time" DESC') }
    belongs_to :brand
    has_many :assignments, as: :assignable, dependent: :destroy
    has_many :users, through: :assignments
    has_one :report, as: :reportable

    validates :name, presence: true
    validates :brand_id, presence: true
    validates :overview, presence: true

    def program_plus_brand
        "#{self.name} (#{self.brand.name})"
    end

    def photos
        event_ids = events.pluck(:id)
        Photo.where(imageable_type: "Event", imageable_id: event_ids)
    end

    def favorite_photos
        # photos.where(program_favorite: true) # Currently just favorite as event photos.
        photos.where(event_favorite: true)
    end

    def first_favorite_photos
        events.each do |single|

        end
        photos.where(event_favorite: true)
    end

    after_create do |program|
    	# Update the brand's users with the new program
    	program.brand.users.each {|user| user.assign_to_program(program)} unless program.brand.nil?
    end
end
