class Video < ActiveRecord::Base
  belongs_to :event
    has_attached_file :media, styles: {
      medium: { format: 'mp4' },
      thumb: { geometry: "300x300#", format: 'jpg',
        output: { vframes: 1, s: '300x300', ss: '00:00:02' }
      }
    }, processors: [:transcoder]
    validates_attachment_content_type :media, :content_type => /\Avideo\/.*\z/
    validates_attachment_presence :media
    validates :event_id, presence: true
end
