require 'rails_helper'

feature 'Program Management' do
    before do
        @brand = create(:brand)
        @program = build(:program)
        @user = create(:user, role: 0)
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Login'
    end
    scenario 'User creates a program' do
        visit brand_programs_path(@brand)
        click_link 'New Program'
        fill_in 'Name', with: @program.name
        expect(find_field('Brand').value).to eq @brand.id.to_s
        click_on 'Create Program'
        expect(page).to have_content @program.name
    end
    context 'User alters existing program' do
        before { @original_program = create(:program, brand_id: @brand.id) }
        scenario 'User edits a program' do
            visit edit_program_path(@original_program)
            fill_in 'Name', with: @program.name
            click_button 'Update Program'
            expect(current_path).to eq "/brands/#{@brand.id}/programs"
            expect(page).to have_content "#{@program.name}"
        end
        scenario 'User deletes a program' do
            visit brand_programs_path(@brand)
            expect(page).to have_css("[href='/programs/#{@original_program.id}']")
            find("[href='/programs/#{@original_program.id}']").click
            expect(page).to have_no_content "#{@original_program.name}"
        end
    end
end
