##
# Handles reporting for programs, aggregates data
class ProgramReport
    include Approval

    def initialize(program, user = nil)
        @program = program
        @user = user
    end

    def name
        @program.name
    end

    def events(user = nil)
        get_approved_events(@program, @user)
    end

    def overview
        @program.overview
    end

    def photos
        @program.photos(@user)
    end

    def favorite_photos
        events(@user).unscope(:order).order(start_date_time: :asc).select { |event| event.favorite_photos.length > 0 }.map { |event| event.favorite_photos.first }
    end

    def first_favorite_photos
        @program.first_favorite_photos(@user)
    end

    def total_impressions
        events(@user).map(&:estimated_total_impressions).reduce(:+)
    end

    def footprint_impressions
        events(@user).map(&:footprint_impressions).reduce(:+)
    end

    def mileage_impressions
        events(@user).map(&:mileage_impressions).reduce(:+)
    end

    def extended_engagements
        events(@user).map(&:extended_engagements).reduce(:+)
    end

    def total_attendance
        events(@user).map(&:total_attendance).reduce(:+)
    end

    def walk_by_impressions
        events(@user).map(&:walk_by_impressions).reduce(:+)
    end

    def digital_engagements
        events(@user).map(&:digital_engagements).reduce(:+)
    end

    def start_date
        minimum = events(@user).map(&:start_date_time).min

        minimum.to_date.strftime('%m/%d/%Y') if minimum
    end

    def end_date
        maximum = events(@user).map(&:end_date_time).max

        maximum.to_date.strftime('%m/%d/%Y') if maximum
    end

    def comments
        event_ids = events(@user).pluck(:id)
        Comment.where(commentable_type: "Event", commentable_id: event_ids, program_favorite: true)
    end

    def aggregate_impression_data
        events(@user).map{ |event|
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

    def event_giveaways
        events(@user).map { |e| e.event_giveaways.map { |eg| eg } }.flatten
    end

    def favorite_giveaways
        events(@user).map do |e|
          e.event_giveaways.select { |giveaway| giveaway.event_favorite > 0 }.map do |eg|
            Hash[eg.giveaway, eg.count_given_away]
          end
        end.flatten.inject do |memo, el|
          memo.merge(el) { |k, old_v, new_v| old_v+new_v }
        end
    end

    def contacts
        events(@user).map(&:contacts).flatten(1).uniq
    end
end
