class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :role, presence: true

  has_many :assignments
  # has_many :events, 
  # 			through: :assignments, 
  # 			source: :event, 
  # 			conditions: "assignments.assignable_type = 'Event'"
  has_many :programs, 
  			through: :assignments, 
  			source: :program, 
  			conditions: "assignments.assignable_type = 'Program'"
  has_many :brands, 
  			through: :assignments, 
  			source: :brand, 
  			conditions: "assignments.assignable_type = 'Brand'"

  def assign_to_brand(brand)
    brand.assignments.create!(user_id: id)
    brand.programs.each do |program|
      assign_to_program(program)
    end
  end
  def assign_to_program(program)
    program.assignments.create!(user_id: id)
  end

  def remove_from_brand(brand)
    brand.assignments.delete(Assignment.where(user_id: id))
    brand.programs.each do |program|
      remove_from_program(program)
    end
  end

  def remove_from_program(program)
    program.assignments.delete(Assignment.where(user_id: id))
    program.brand.assignments.delete(Assignment.where(user_id: id))
  end

  def events
    program_ids = programs.pluck(:id)
    Event.where(program_id: program_ids)
  end

end
