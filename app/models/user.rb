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
  			-> { where "assignments.assignable_type = 'Program'" },
        through: :assignments, 
        source: :program
  has_many :brands, 
  			-> {where "assignments.assignable_type = 'Brand'"},
        through: :assignments, 
        source: :brand

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

  def assign(assignment)
    case assignment.class.name
    when 'Brand'
      assign_to_brand(assignment)
    when 'Program'
      assign_to_program(assignment)
    else
    end
  end

  def unassign(assignment)
    case assignment.class.name
    when 'Brand'
      remove_from_brand(assignment)
    when 'Program'
      remove_from_program(assignment)
    else
    end
  end

  def events
    return Event.all if is_admin?
    program_ids = programs.pluck(:id)
    Event.where(program_id: program_ids)
  end

  def is_admin?
    role == 0
  end

  def role_in_words
    case role
    when 0
      'Administrator'
    when 3
      'Program Manager'
    when 2
      'Client'
    when 1
      'Field Staff'
    else
      'Guest'
    end
  end

  def has_assignments?
    assignments.count > 0
  end
end
