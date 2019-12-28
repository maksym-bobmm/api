# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Excavator, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:ticket_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:excavator).of_type(:json).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end
  describe 'validation' do
    context 'root keys' do
      %i[excavator].each do |column|
        it { is_expected.to validate_presence_of(column) }
      end
    end
    context 'subkeys' do
      %i[excavator_without_company_name
         excavator_without_crew_on_site
         excavator_without_address
         excavator_without_city
         excavator_without_state
         excavator_without_zip].each do |factory|
        it "is expected not to be valid on #{factory}" do
          expect(build(factory)).to_not be_valid
        end
      end
    end
  end
  describe 'association' do
    it { is_expected.to belong_to(:ticket) }
  end
end
