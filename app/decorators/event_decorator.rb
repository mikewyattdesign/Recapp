class EventDecorator
    include ActionView::Helpers::DateHelper

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
end
