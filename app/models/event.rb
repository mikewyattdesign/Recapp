class Event < ActiveRecord::Base
    belongs_to :program
    has_many :comments, inverse_of: :event
    has_many :photos, as: :imageable
    has_many :event_giveaways, inverse_of: :event
    has_many :giveaways, through: :event_giveaways
    has_one :weather
    has_many :tags, as: :taggable

    accepts_nested_attributes_for :event_giveaways
    accepts_nested_attributes_for :giveaways
    accepts_nested_attributes_for :weather

    validates :start_date_time, presence: true
    validates :end_date_time, presence: true
    validates :name, presence: true
    validates :program_id, presence: true

    # Virtual Attributes to simplify Start and End Date Time Entry
    def start_time
        start_date_time.localtime.strftime("%I:%M %p") if start_date_time.present?
    end

    def start_time=(time)
        t = Time.parse(time)
        if self.start_date_time.present?
            d = self.start_date_time.to_date
        else
            d = Date.today
        end

        self.start_date_time = DateTime.new(d.year, d.month, d.day, t.gmtime.hour, t.gmtime.min, t.gmtime.sec)
    end

    def start_date
        start_date_time.to_date.strftime("%m/%d/%Y") if start_date_time.present?
    end

    def start_date=(date)
        d = Date.strptime(date, "%m/%d/%Y")
        if self.start_date_time.present?
            t = self.start_date_time.to_time
        else
            t = DateTime.now.to_time
        end

        self.start_date_time = DateTime.new(d.year, d.month, d.day, t.gmtime.hour, t.gmtime.min, t.gmtime.sec)
    end

    def end_time
        end_date_time.localtime.strftime("%I:%M %p") if end_date_time.present?
    end

    def end_time=(time)
        t = Time.parse(time)
        if self.end_date_time.present?
            d = self.end_date_time.to_date
        else
            d = Date.today
        end
        self.end_date_time = DateTime.new(d.year, d.month, d.day, t.gmtime.hour, t.gmtime.min, t.gmtime.sec)
    end

    def end_date
        end_date_time.to_date.strftime("%m/%d/%Y") if end_date_time.present?
    end

    def end_date=(date)
        d = Date.strptime(date, "%m/%d/%Y")
        if self.end_date_time.present?
            t = self.end_date_time.to_time
        else
            t = DateTime.now.to_time
        end
        self.end_date_time = DateTime.new(d.year, d.month, d.day, t.gmtime.hour, t.gmtime.min, t.gmtime.sec)
    end

end
