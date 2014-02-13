class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments, as: :assignable
  has_many :events, 
  			through: :assignments, 
  			source: :event, 
  			conditions: "assignments.assignable_type = 'Event'"
  has_many :programs, 
  			through: :assignments, 
  			source: :program, 
  			conditions: "assignments.assignable_type = 'Program'"
  has_many :brands, 
  			through: :assignments, 
  			source: :brand, 
  			conditions: "assignments.assignable_type = 'Brand'"
end
