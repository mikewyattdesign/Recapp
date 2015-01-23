class Request < ActiveRecord::Base
  belongs_to :requestor, class_name: "User"
  belongs_to :requestable, polymorphic: true
  belongs_to :brand, class_name: "Brand", foreign_key: "requestable_id"
  belongs_to :program, class_name: "Program", foreign_key: "requestable_id"
  belongs_to :event, class_name: "Event", foreign_key: "requestable_id"
  belongs_to :photo, class_name: "Photo", foreign_key: "requestable_id"
  belongs_to :user, class_name: "User", foreign_key: "requestable_id"
  belongs_to :document, class_name: "Document", foreign_key: "requestable_id"
  belongs_to :giveaway, class_name: "Giveaway", foreign_key: "requestable_id"
  belongs_to :link, class_name: "Link", foreign_key: "requestable_id"
  belongs_to :video, class_name: "Video", foreign_key: "requestable_id"

  validates :requestor, presence: true
  validates :requestable_id, presence: true
  validates :requestable_type, presence: true
end
