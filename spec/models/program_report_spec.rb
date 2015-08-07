require 'rails_helper'

describe ProgramReport do
    let(:program) { create(:program) }

    subject { described_class.new program }

    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :events }
    it { is_expected.to respond_to :overview }
    it { is_expected.to respond_to :photos }
    it { is_expected.to respond_to :total_impressions }
    it { is_expected.to respond_to :mileage_impressions }
    it { is_expected.to respond_to :footprint_impressions }
    it { is_expected.to respond_to :walk_by_impressions }
    it { is_expected.to respond_to :digital_engagements }
    it { is_expected.to respond_to :extended_engagements }
    it { is_expected.to respond_to :total_attendance }
    it { is_expected.to respond_to :start_date }
    it { is_expected.to respond_to :end_date }
    it { is_expected.to respond_to :comments }

    it 'has the correct name' do
        expect(subject.name).to eq program.name
    end

    context 'when reporting on a Program' do
        let!(:events) { create_list(:event, 3, program_id: program.id) }

        it 'has the correct events' do
            expect(subject.events).to eq events
        end

        it 'gives the start date of the Program' do
            one_year_ago = 1.year.ago
            events[0].update_attribute :start_date_time, one_year_ago
            expect(subject.start_date.to_s).to eq one_year_ago.strftime('%m/%d/%Y')
        end

        it 'gives the end date of the Program' do
            one_year_from_now = 1.year.since
            events[0].update_attribute :end_date_time, one_year_from_now
            expect(subject.end_date.to_s).to eq one_year_from_now.strftime('%m/%d/%Y')
        end
    end
end
