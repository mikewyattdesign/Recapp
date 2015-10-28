class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :role, presence: true

  has_many :assignments, -> {where "assignments.assignable_id IS NOT NULL"}, dependent: :destroy
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

  has_many :api_keys

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
    return Event.all if is_approver? || is_super_admin? || is_admin? || is_g360?
    program_ids = programs.pluck(:id)
    Event.where(program_id: program_ids)
  end

  def self.roles
    [
      ["Guest",-1],
      ["Client",2],
      ["G360",4],
      ["Field Staff",1],
      ["Administrator",3],
      ["Super Administrator",0],
      ["Approver",5]
    ]
  end
  def is_approver?
    role == 5
  end
  def is_super_admin?
    role == 0
  end

  def is_admin?
    role == 3
  end

  def is_client?
    role == 2
  end

  def is_field_staff?
    role == 1
  end

  def is_g360?
    role == 4
  end

  def is_guest?
    !(is_approver? || is_super_admin? || is_admin? || is_client? || is_field_staff? || is_g360?)
  end

  def role_in_words
    case role
    when 0
      'Super Administrator'
    when 3
      'Administrator'
    when 2
      'Client'
    when 1
      'Field Staff'
    when 4
      'GROUP360'
    when 5
      'Approver'
    else
      'Guest'
    end
  end

  def has_assignments?
    assignments.count > 0
  end
end
