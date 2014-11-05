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

    def total_impressions
        events.map(&:estimated_total_impressions).reduce(:+)
    end

    def start_date
        events.map(&:start_date_time).min.to_date
    end

    def end_date
        events.map(&:end_date_time).max.to_date
    end
end
