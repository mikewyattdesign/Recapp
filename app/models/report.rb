class Report < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true
  has_attached_file :report
  validates_attachment_content_type :report, content_type: /application\/pdf/

    def self.with_event
        Report.where(id: (Report.where(reportable_type: 'Event').reject{|p| p.event.nil?}.map{|p|p.id}))
    end

    def event
        if reportable_type == Event.name
            Event.find(reportable_id) if Event.where(id: reportable_id).count > 0
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
