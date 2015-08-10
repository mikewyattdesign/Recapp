require 'rails_helper'

describe Program do
    it 'is valid with a name, brand_id, and overview' do
        brand = create(:brand)
        program = Program.new(name: 'Heroes', brand_id: brand.id, overview: 'Heroes are great!')
        expect(program).to be_valid
    end
    it 'is invalid without a name' do
        expect do
            Program.create!(name: nil)
        end.to raise_error(
            ActiveRecord::RecordInvalid,
            /name can't be blank/i
        )
    end
    it 'is invalid without a brand_id' do
        expect do
            Program.create!(brand_id: nil)
        end.to raise_error(
            ActiveRecord::RecordInvalid,
            /brand can't be blank/i
        )
    end
    it 'is invalid without an overview' do
        expect do
            Program.create!(overview: nil)
        end.to raise_error(
            ActiveRecord::RecordInvalid,
            /overview can't be blank/i
        )
    end
    it 'responds to brand' do
        brand = create(:brand)
        expect(Program.new(
            name: 'Heroes',
            brand_id: brand.id
        )).to respond_to(:brand)
    end
    it 'returns its brand' do
        busch = create(:brand)
        program = Program.new(name: 'Heroes', brand_id: busch.id, overview: 'Heroes are great!')
        expect(program.brand).to eq busch
    end
    it 'responds to events' do
        brand = create(:brand)
        expect(Program.new(
            name: 'Heroes',
            brand_id: brand.id
        )).to respond_to(:events)
    end
end
