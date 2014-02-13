class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignable, polymorphic: true
  belongs_to :event, class_name: "Event", foreign_key: "assignable_id"
  belongs_to :program, class_name: "Program", foreign_key: "assignable_id"
  belongs_to :brand, class_name: "Brand", foreign_key: "assignable_id"


  validates :user_id, presence: true
  validates :assignable_type, presence: true
  validates :assignable_id, presence: true
end
