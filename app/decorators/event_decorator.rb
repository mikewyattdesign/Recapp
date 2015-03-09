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
        event.favorite_photos.first.image
    end

    def favorite_photo_sub(index)
        event.favorite_photos[(event.favorite_photos.length > 0 && index < event.favorite_photos.length) ? index : (index % event.favorite_photos.length)].image
    end
end
