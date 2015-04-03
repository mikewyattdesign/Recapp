class Photo < ActiveRecord::Base
    after_create :queue_processing

    # TODO: Add paperclip relationships and validation
    has_attached_file :image, styles: {large: '700x700', medium: '500x500', small: '300x300'}
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

    has_many :comments, as: :commentable
    belongs_to :imageable, polymorphic: true
    acts_as_taggable

    def self.with_event
    	Photo.where(id: (Photo.where(imageable_type: 'Event').reject{|p| p.event.nil?}.map{|p|p.id}))
    end

    def event
    	if imageable_type == Event.name
    		Event.find(imageable_id) if Event.where(id: imageable_id).count > 0
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

    def favorited
        event_favorite || program_favorite || brand_favorite
    end

    def self.transfer_and_cleanup(id)
        # Get the photo to be processed
        photo = Photo.find(id)

        # final destination with the leading slashed sliced off
        paperclip_file_path = photo.image.path.slice(1..-1)
        # temp source
        source = photo.direct_upload_file_path
        Photo.copy_and_delete paperclip_file_path, source

        photo.image.reprocess!

        photo.processed = true
        photo.save

    end

    def self.copy_and_delete(paperclip_file_path, raw_source)
        s3 = AWS::S3.new
        destination = s3.buckets[S3DirectUpload.config.bucket].objects[paperclip_file_path]
        source = s3.buckets['nutshell-360-temp'].objects[raw_source]
        source.copy_to(destination, acl: :public_read)
        source.delete
    end

    def queue_processing
        Photo.delay.transfer_and_cleanup(id)
    end

    def process
        Photo.transfer_and_cleanup(id)
    end

    def direct_upload_file_path
        CGI.unescape direct_upload_url.gsub("https://s3.amazonaws.com/nutshell-360-temp/","")
    end
end
