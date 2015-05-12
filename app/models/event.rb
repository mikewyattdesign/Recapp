class Event < ActiveRecord::Base
    belongs_to :program
    has_many :comments, as: :commentable
    has_many :photos, as: :imageable
    has_many :event_giveaways, inverse_of: :event
    has_many :giveaways, through: :event_giveaways
    has_one :weather
    has_many :assignments, as: :assignable
    has_many :videos
    has_many :documents, as: :documentable
    has_many :links, as: :linkable
    has_many :event_favorite_photos, inverse_of: :event
    has_many :favorite_photos, -> { order('"event_favorite_photos"."order" ASC') } ,through: :event_favorite_photos, source: :photo
    has_and_belongs_to_many :contacts
    acts_as_taggable

    accepts_nested_attributes_for :event_giveaways, allow_destroy: true
    accepts_nested_attributes_for :links, allow_destroy: true
    accepts_nested_attributes_for :giveaways
    accepts_nested_attributes_for :weather
    accepts_nested_attributes_for :comments, allow_destroy: true

    before_save :ensure_not_nil

    validates :start_date_time, presence: true
    validates :end_date_time, presence: true
    validates :name, presence: true
    validates :program_id, presence: true

    validates :city, presence: true
    validates :state, length: { is: 2 }, format: { with: /[A-Z]{2}/, message: "- State abbreviation only"}, presence: true
    validates :postal_code, length: { is: 5}, format: { with: /[0-9]{5}/, message: "- Five digit postal code"}, allow_blank: true

    validates_with DateValidator

    # Virtual Attributes to simplify Start and End Date Time Entry

    def start_date
        start_date_time.to_date.strftime('%m/%d/%Y') if start_date_time.present?
    end

    def start_date=(date)
        d = Date.strptime(date, '%m/%d/%Y')
        if start_date_time.present?
            t = start_date_time.to_time
        else
            t = DateTime.now.to_time
        end

        self.start_date_time = DateTime.new(
            d.year,
            d.month,
            d.day,
            t.gmtime.hour,
            t.gmtime.min,
            t.gmtime.sec
        )
    end

    def start_time
        if start_date_time.present?
            start_date_time.localtime.strftime('%I:%M %p')
        else
            '12:00 AM'
        end
    end

    def start_time=(time)
        t = Time.strptime(time, '%I:%M %p', start_date_time)
        if start_date_time.present?
            d = start_date_time.to_time
        else
            d = DateTime.now.to_time
        end

        self.start_date_time = DateTime.new(
            d.year,
            d.month,
            d.day,
            t.gmtime.hour,
            t.gmtime.min,
            t.gmtime.sec
        )
    end

    def end_time
        if end_date_time.present?
            end_date_time.localtime.strftime('%I:%M %p')
        else
            '12:00 AM'
        end
    end

    def end_time=(time)
        t = Time.strptime(time, '%I:%M %p', end_date_time)
        if end_date_time.present?
            d = end_date_time.to_time
        else
            d = DateTime.now.to_time
        end

        self.end_date_time = DateTime.new(
            d.year,
            d.month,
            d.day,
            t.gmtime.hour,
            t.gmtime.min,
            t.gmtime.sec
        )
    end

    def end_date
        end_date_time.to_date.strftime('%m/%d/%Y') if end_date_time.present?
    end

    def end_date=(date)
        d = Date.strptime(date, '%m/%d/%Y')
        if end_date_time.present?
            t = end_date_time.to_time
        else
            t = DateTime.now.to_time
        end
        self.end_date_time = DateTime.new(
            d.year,
            d.month,
            d.day,
            t.gmtime.hour,
            t.gmtime.min,
            t.gmtime.sec
        )
    end

    def estimated_total_impressions
        mileage_impressions + walk_by_impressions
    end

    def miles
        mileage_rate =  101
        mileage_impressions / mileage_rate
    end

    def miles=(mileage)
        mileage_rate = 101
        self.mileage_impressions = mileage_rate * mileage.to_f
    end

    def past?
        end_date_time < DateTime.now
    end

    def to_xls
        <<-XLS
            <Row>
                <Cell><Data ss:Type='String'>#{name}</Data></Cell>
                <Cell><Data ss:Type='String'>#{program.brand.name}</Data></Cell>
                <Cell><Data ss:Type='String'>#{program.name}</Data></Cell>
                <Cell><Data ss:Type='String'>#{start_date}</Data></Cell>
                <Cell><Data ss:Type='String'>#{start_time}</Data></Cell>
                <Cell><Data ss:Type='String'>#{end_date}</Data></Cell>
                <Cell><Data ss:Type='String'>#{end_time}</Data></Cell>
                <Cell><Data ss:Type='String'>#{street}</Data></Cell>
                <Cell><Data ss:Type='String'>#{city}</Data></Cell>
                <Cell><Data ss:Type='String'>#{state}</Data></Cell>
                <Cell><Data ss:Type='String'>#{postal_code}</Data></Cell>
                <Cell><Data ss:Type='String'>#{total_attendance}</Data></Cell>
                <Cell><Data ss:Type='String'>#{mileage_impressions}</Data></Cell>
                <Cell><Data ss:Type='String'>#{walk_by_impressions}</Data></Cell>
                <Cell><Data ss:Type='String'>#{footprint_impressions}</Data></Cell>
                <Cell><Data ss:Type='String'>#{extended_engagements}</Data></Cell>
                <Cell><Data ss:Type='String'>#{digital_engagements}</Data></Cell>
                <Cell><Data ss:Type='String'>#{brand_demo_fit}</Data></Cell>
                <Cell><Data ss:Type='String'>#{wholesaler_or_local_support}</Data></Cell>
                <Cell><Data ss:Type='String'>#{note}</Data></Cell>
            </Row
        XLS
    end

    def update(params)
        completed_at.present? ? false : super
    end

    private

    # Each of these properties has a NOT NULL designation in the
    # database
    def ensure_not_nil
        self.digital_engagements = 0 if digital_engagements.blank?
        self.mileage_impressions = 0 if mileage_impressions.blank?
        self.footprint_impressions = 0 if footprint_impressions.blank?
        self.walk_by_impressions = 0 if walk_by_impressions.blank?
        self.total_attendance = 0 if total_attendance.blank?
        self.extended_engagements = 0 if extended_engagements.blank?
    end
end
