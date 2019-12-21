require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'column' do
    %i[id request_number request_type sequence_number date_times service_area digsite_info
     created_at updated_at].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
  describe 'validation' do
    %i[request_number request_type sequence_number date_times service_area digsite_info
     created_at updated_at].each do |column|
      it { is_expected.to validate_presence_of(column) }
    end
  end
  describe 'association' do
    it { is_expected.to have_one(:excavator) }
  end
end
