class Program < ActiveRecord::Base
    include Approval

    has_many :events, -> {order('"events"."start_date_time" DESC') }
    belongs_to :brand
    has_many :assignments, as: :assignable, dependent: :destroy
    has_many :users, through: :assignments
    has_one :report, as: :reportable

    has_many :comments, through: :events

    validates :name, presence: true
    validates :brand_id, presence: true
    validates :overview, presence: true

    accepts_nested_attributes_for :comments

    scope :approved, -> { where('programs.approved = ?', true) }

    def program_plus_brand
        "#{self.name} (#{self.brand.name})"
    end

    def photos(user = nil)
        event_ids = get_approved_events(self, user).pluck(:id)
        Photo.where(imageable_type: "Event", imageable_id: event_ids)
    end

    def favorite_photos(user = nil)
        # photos.where(program_favorite: true) # Currently just favorite as event photos.
        photos(user).where(event_favorite: true)
    end

    def first_favorite_photos(user = nil)
        get_approved_events(self, user).select{|e| e.favorite_photos.count}.map do |event|
            event.favorite_photos.first
        end
    end

    after_create do |program|
    	# Update the brand's users with the new program
    	program.brand.users.each {|user| user.assign_to_program(program)} unless program.brand.nil?
    end
end
