##
# Handles reporting for programs, aggregates data
class ProgramReport
    def initialize(program)
        @program = program
    end

    def name
        @program.name
    end

    def events
        @program.events
    end

    def overview
        @program.overview
    end

    def photos
        @program.photos
    end

    def total_impressions
        events.map(&:estimated_total_impressions).reduce(:+)
    end

    def footprint_impressions
        events.map(&:footprint_impressions).reduce(:+)
    end

    def mileage_impressions
        events.map(&:mileage_impressions).reduce(:+)
    end

    def extended_engagements
        events.map(&:extended_engagements).reduce(:+)
    end

    def total_attendance
        events.map(&:total_attendance).reduce(:+)
    end

    def walk_by_impressions
        events.map(&:walk_by_impressions).reduce(:+)
    end

    def digital_engagements
        events.map(&:digital_engagements).reduce(:+)
    end

    def start_date
        minimum = events.map(&:start_date_time).min

        minimum.to_date if minimum
    end

    def end_date
        maximum = events.map(&:end_date_time).max

        maximum.to_date if maximum
    end

    def comments
        comments = events.map(&:comments).flatten(1)
    end

    def aggregate_impression_data
        events.map{ |event|
            {name: event.name,
                data: [
                        ['Total Impressions',     event.estimated_total_impressions],
                        ['Mileage Impressions',   event.mileage_impressions],
                        ['Footprint Impressions', event.footprint_impressions],
                        ['Walk by Impressions',   event.walk_by_impressions],
                        ['Digital Engagements',   event.digital_engagements],
                        ['Extended Engagements',  event.extended_engagements],
                        ['Total Attendance',      event.total_attendance]
                    ]
                }
            }

    end
end
