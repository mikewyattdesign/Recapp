require 'spec_helper'

feature 'User Management' do
	before {
		3.times {create(:brand)}
		Brand.each {|brand| 3.times{ create(:program, brand_id: brand.id)} }
		@brand = Brand.first
		@program = @brand.programs.first
		@user = create(:user)
	}
end