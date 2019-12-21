require 'rails_helper'

RSpec.describe Excavator, type: :model do
  describe 'columns' do
    %i[id excavator created_at updated_at].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
  describe 'validation' do
    %i[excavator created_at updated_at].each do |column|
      it { is_expected.to validate_presence_of(column) }
    end
  end
  describe 'association' do
    it { is_expected.to belong_to(:ticket) }
  end
end
