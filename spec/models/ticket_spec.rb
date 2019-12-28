# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'column' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    %i[request_number sequence_number request_type].each do |column|
      it { is_expected.to have_db_column(column).of_type(:string).with_options(null: false) }
    end
    %i[date_times service_area digsite_info].each do |column|
      it { is_expected.to have_db_column(column).of_type(:json).with_options(null: false) }
    end
    %i[created_at updated_at].each do |column|
      it { is_expected.to have_db_column(column).of_type(:datetime).with_options(null: false) }
    end
  end
  describe 'validation' do
    context 'root keys' do
      %i[request_number request_type sequence_number date_times service_area digsite_info].each do |column|
        it { is_expected.to validate_presence_of(column) }
      end
    end
    context 'subkeys' do
      %i[ticket_without_response_due_date_time
         ticket_without_primary_sacode
         ticket_without_additional_sacode
         ticket_without_well_known_text].each do |factory|
        it "is expected not to be valid on #{factory}" do
          expect(build(factory)).to_not be_valid
        end
      end
    end
    it 'is expected not to be valid without date_times -> ResponseDueDateTime' do
      expect(build(:ticket_without_response_due_date_time)).to_not be_valid
    end
  end
  describe 'association' do
    it { is_expected.to have_one(:excavator) }
    it { is_expected.to accept_nested_attributes_for(:excavator) }
  end
end
