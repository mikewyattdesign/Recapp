class Event < ActiveRecord::Base
    belongs_to :program
    has_many :comments, inverse_of: :event
    has_many :photos, as: :imageable
    has_many :event_giveaways, inverse_of: :event
    has_many :giveaways, through: :event_giveaways
    has_one :weather
    has_many :assignments, as: :assignable
    has_many :videos
    acts_as_taggable

    accepts_nested_attributes_for :event_giveaways, allow_destroy: true
    accepts_nested_attributes_for :giveaways
    accepts_nested_attributes_for :weather

    validates :start_date_time, presence: true
    validates :end_date_time, presence: true
    validates :name, presence: true
    validates :program_id, presence: true
    validates_with DateValidator

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
    def estimated_total_impressions
        mileage_impressions + walk_by_impressions
    end
    def miles
        mileage_rate =  82
        mileage_impressions / mileage_rate
    end
    def miles=(mileage)
        mileage_rate = 82
        self.mileage_impressions = mileage_rate * mileage.to_f
    end

    def past?
        end_date_time < DateTime.now
    end

    def to_xls
       [
            "<Row>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{name}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{program.brand.name}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{program.name}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{start_date}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{start_time}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{end_date}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{end_time}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{street}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{city}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{state}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{postal_code}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{country}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{total_attendance}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{mileage_impressions}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{walk_by_impressions}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{footprint_impressions}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{extended_engagements}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{digital_engagements}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{brand_demo_fit}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{wholesaler_or_local_support}</Data></Cell>",
                "<Cell><Data ss:Type=" + '"String"' + ">#{note}</Data></Cell>",
            "</Row>"
        ].join('')
    end
end
