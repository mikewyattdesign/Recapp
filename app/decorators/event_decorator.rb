class EventDecorator
    include ActionView::Helpers

    attr_reader :event

    def initialize(event)
        @event = event
    end

    def method_missing(method_name, *args, &block)
        event.send(method_name, *args, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
        event.respond_to?(method_name, include_private) || super
    end

    def duration
        distance_of_time_in_words(event.start_date_time, event.end_date_time)
    end

    def brand
        event.program.brand
    end

    def location
        "#{event.city}, #{event.state}" unless event.city.blank? || event.state.blank?
    end

    def venue
        "#{event.venue}" unless event.venue.blank?
    end

    def overview
        "#{event.overview}" unless event.overview.blank?
    end

    def photo
        if event.photos.last.present?
            image_tag event.photos.last.image(:large), class: 'event-img'
        elsif event.past?
            link_to 'Add an event photo', "/events/#{event.id}/photos/new", class: 'no-event-photos'
        else
            nil
        end
    end

    def favorite_photo_main
        if event.favorite_photos[0].present?
            image_tag event.favorite_photos[0].image(:medium), class: 'img-responsive pdf-photo pdf-photo-main'
        end
    end

    def favorite_photo_sub(index)
        if (event.favorite_photos.length > 0) && (index < event.favorite_photos.length)
            image_tag event.favorite_photos[index].image(:small), class: 'img-responsive pdf-photo pdf-photo-sub'
        else
            nil # don't show any more than the number of favorited photos
        end
    end
end
