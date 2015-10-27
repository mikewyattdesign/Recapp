##
# Handles reporting for programs, aggregates data
class ProgramReport
    def initialize(program, user = nil)
        @program = program
        @user = user
    end

    def name
        @program.name
    end

    def events
        (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
    end

    def overview
        @program.overview
    end

    def photos
        @program.photos(@user)
    end

    def favorite_photos
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.unscope(:order).order(start_date_time: :asc).select { |event| event.favorite_photos.length > 0 }.map { |event| event.favorite_photos.first }
    end

    def first_favorite_photos
        @program.first_favorite_photos(@user)
    end

    def total_impressions
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map(&:estimated_total_impressions).reduce(:+)
    end

    def footprint_impressions
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map(&:footprint_impressions).reduce(:+)
    end

    def mileage_impressions
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map(&:mileage_impressions).reduce(:+)
    end

    def extended_engagements
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map(&:extended_engagements).reduce(:+)
    end

    def total_attendance
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map(&:total_attendance).reduce(:+)
    end

    def walk_by_impressions
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map(&:walk_by_impressions).reduce(:+)
    end

    def digital_engagements
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map(&:digital_engagements).reduce(:+)
    end

    def start_date
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        minimum = events.map(&:start_date_time).min

        minimum.to_date.strftime('%m/%d/%Y') if minimum
    end

    def end_date
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        maximum = events.map(&:end_date_time).max

        maximum.to_date.strftime('%m/%d/%Y') if maximum
    end

    def comments
        event_ids = (@user.present? && @user.is_client?) ? @program.events.approved.pluck(:id) : @program.events.pluck(:id)
        Comment.where(commentable_type: "Event", commentable_id: event_ids, program_favorite: true)
    end

    def aggregate_impression_data
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map{ |event|
            {name: event.name,
                data: [
                        ['',],
                        ['Total Impressions',     event.estimated_total_impressions],
                        ['Mileage Impressions',   event.mileage_impressions],
                        ['Footprint Impressions', event.footprint_impressions],
                        ['Walk by Impressions',   event.walk_by_impressions],
                        ['Digital Engagements',   event.digital_engagements],
                        ['Extended Engagements',  event.extended_engagements]
                    ]
                }
            }
    end

    def contacts
        events = (@user.present? && @user.is_client?) ? @program.events.approved : @program.events
        events.map(&:contacts).flatten(1).uniq
    end
end
