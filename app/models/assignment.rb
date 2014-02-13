class Assignment < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :assignable_type, presence: true
  validates :assignable_id, presence: true
end
