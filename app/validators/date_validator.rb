class DateValidator < ActiveModel::Validator
    def validate(record)
        if record.end_date_time.present? && record.start_date_time.present?
            if record.end_date_time.to_date < record.start_date_time.to_date
                record.errors[:end_date_time] << "End date time comes before start date time"
            end
        end
    end
end