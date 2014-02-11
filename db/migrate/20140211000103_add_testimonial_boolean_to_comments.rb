class AddTestimonialBooleanToComments < ActiveRecord::Migration
  def change
    add_column :comments, :is_testimonial, :boolean, default: false
  end
end
