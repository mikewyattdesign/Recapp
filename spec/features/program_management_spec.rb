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
            first("[href='/programs/#{original_program.id}'][data-method='delete']").click
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

    context "when visiting a program's overview page" do
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
        it { is_expected.to have_content 'Mileage Impressions' }
        it { is_expected.to have_content 'Footprint Impressions' }
        it { is_expected.to have_content 'Walk by Impressions' }
        it { is_expected.to have_content 'Digital Engagements' }
        it { is_expected.to have_content 'Extended Engagements' }
        it { is_expected.to have_content 'Total Attendance' }
        it { is_expected.to have_content 'Start Date' }
        it { is_expected.to have_content 'End Date' }

        it 'has the start date listed' do
            one_year_ago = 1.year.ago
            events[0].update_attribute :start_date_time, one_year_ago
            visit program_path(program)
            expect(page.body).to have_content one_year_ago.to_date.to_s
        end

        it 'has the end date listed' do
            one_year_from_now = 1.year.since
            events[1].update_attribute :end_date_time, one_year_from_now
            visit program_path(program)
            expect(page.body).to have_content one_year_from_now.to_date.to_s
        end
    end
end
