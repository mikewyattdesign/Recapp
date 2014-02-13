class AddAssignableToAssignments < ActiveRecord::Migration
  def change
    add_reference :assignments, :assignable, polymorphic: true
  end
end
