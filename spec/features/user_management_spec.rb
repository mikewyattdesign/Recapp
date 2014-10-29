require 'rails_helper'

feature 'User Management' do
    before do
        3.times { create(:brand) }
        Brand.all.each do |brand|
            3.times do
                create(:program, brand_id: brand.id)
            end
        end
        @brand = Brand.first
        @program = @brand.programs.first
        @user = create(:user)
    end
    scenario 'Assign a user to a brand' do
        visit user_management_path
    end
end
