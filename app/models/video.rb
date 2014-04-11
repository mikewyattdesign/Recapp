class Video < ActiveRecord::Base
	belongs_to :event
    has_attached_file :media    
    validates_attachment_content_type :media, :content_type => /\Avideo\/.*\z/
end
