class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true
  has_attached_file :doc
  validates_attachment_content_type :doc, content_type: /\Aapplication\/msword|vnd\.openxmlformats-officedocument\.wordprocessingml\.document|vnd\.ms-excel|vnd\.openxmlformats-officedocument\.spreadsheetml\.sheet|vnd\.ms-powerpoint|vnd\.openxmlformats-officedocument\.presentationml\.presentation|pdf/
  validates_attachment_presence :doc

    def self.with_event
    	Document.where(id: (Document.where(documentable_type: 'Event').reject{|p| p.event.nil?}.map{|p|p.id}))
    end

    def event
    	if documentable_type == Event.name 
    		Event.find(documentable_id) if Event.where(id: documentable_id).count > 0
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
