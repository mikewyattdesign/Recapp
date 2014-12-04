class Comment < ActiveRecord::Base

    belongs_to :commentable, polymorphic: true
    has_many :comments, as: :commentable
    # belongs_to :event, inverse_of: :comments
    # validates :event_id, presence: true

    def self.comment_types
    	[["Consumer",1],["General",2],["Corporate",3],["Wholesaler/Field",4],["Retailer",5],["Other",6]]
    end

    def type_in_words
    	Comment.comment_types[self.comment_type - 1][0]
    end
end
