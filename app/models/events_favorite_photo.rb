class EventsFavoritePhoto < ActiveRecord::Base
    belongs_to :event
    belongs_to :photo
end