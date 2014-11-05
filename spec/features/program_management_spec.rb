require 'rails_helper'

feature 'Program Management' do
    let(:brand) { create(:brand) }
    let(:program) { create(:program, brand_id: brand.id) }
    let(:user) { create(:user, role: 0) }

    before do
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Login'
    end

    scenario 'User creates a program' do
        visit brand_programs_path(brand)
        click_link 'New Program'
        fill_in 'Name', with: program.name
        expect(find_field('Brand').value).to eq brand.id.to_s
        click_on 'Create Program'
        expect(page).to have_content program.name
    end

    context 'User alters existing program' do
        let!(:original_program) { create(:program, brand_id: brand.id) }

        scenario 'User edits a program' do
            visit edit_program_path(original_program)
            fill_in 'Name', with: program.name
            click_button 'Update Program'
            expect(current_path).to eq "/brands/#{brand.id}/programs"
            expect(page).to have_content "#{program.name}"
        end

        scenario 'User deletes a program' do
            visit brand_programs_path(brand)
            expect(page).to have_css("[href='/programs/#{original_program.id}']")
            find("[href='/programs/#{original_program.id}']").click
            expect(page).to have_no_content "#{original_program.name}"
        end
    end

    context "when visiting a brand's page" do
        before do
            program # So a program inside of a brand is created
            visit brands_path
            click_link 'Programs'
        end

        subject { page.body }

        it { is_expected.to have_content program.name }
        it { is_expected.to have_link program.name }
    end

    context "when visiting a program's overview page", focus: true do
        let!(:events) { create_list(:event, 3, program_id: program.id) }
        before { visit program_path(program) }

        subject { page.body }

        it { is_expected.to have_content program.name }

        it 'has a list of the events in the program' do
            events.each do |event|
                expect(subject).to have_link event.name
            end
        end

        it { is_expected.to have_content 'Total Impressions' }
    end
end
