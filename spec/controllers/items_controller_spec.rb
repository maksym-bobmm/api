# frozen_string_literal: true

require 'rails_helper'
require 'active_support/all'

RSpec.describe Api::ItemsController, type: :controller do
  # rubocop:disable Security/MarshalLoad
  before(:all) do
    dump = Marshal.dump(receive_correct_json)
    @correct_json_data = Marshal.load(dump)
    @wrong_json_root_keys = Marshal.load(dump)
    @wrong_json_subkeys = Marshal.load(dump)

    @wrong_json_root_keys.delete('RequestNumber')
    @wrong_json_root_keys.delete('ServiceArea')
    @wrong_json_subkeys['ServiceArea'].delete('PrimaryServiceAreaCode')
    @wrong_json_subkeys['ExcavationInfo'].delete('DigsiteInfo')
  end
  # rubocop:enable Security/MarshalLoad

  describe 'route' do
    it { is_expected.to route(:post, '/api/items').to(action: :create, format: :json) }
  end

  describe 'POST #create' do
    let(:correct_query) { post :create, params: @correct_json_data, as: :json }
    let(:wrong_query_missed_root_keys) { post :create, params: @wrong_json_root_keys, as: :json }
    let(:wrong_query_missed_subkeys) { post :create, params: @wrong_json_subkeys, as: :json }
    context 'gets status' do
      it '201 with correct json' do
        correct_query
        expect(response).to have_http_status(201)
      end
      it '422 with wrong json(missed some root keys)' do
        wrong_query_missed_root_keys
        expect(response).to have_http_status(422)
      end
      it '422 with wrong json(missed some subkeys)' do
        wrong_query_missed_subkeys
        expect(response).to have_http_status(422)
      end
    end
    context 'action' do
      it 'change Ticket count with correct json' do
        expect do
          correct_query
        end.to change { Ticket.count }
      end
      it 'does not change Ticket\'s count wrong json(missed some root keys)' do
        expect do
          wrong_query_missed_root_keys
        end.to_not change { Ticket.count }
      end
      it 'does not change Ticket\'s count with wrong json(missed some subkeys)' do
        expect do
          wrong_query_missed_subkeys
        end.to_not change { Ticket.count }
      end
      it 'change Excavator count with correct json' do
        expect do
          correct_query
        end.to change { Excavator.count }
      end
      it 'does not change Excavator\'s count wrong json(missed some root keys)' do
        expect do
          wrong_query_missed_root_keys
        end.to_not change { Excavator.count }
      end
      it 'does not change Excavator\'s count with wrong json(missed some subkeys)' do
        expect do
          wrong_query_missed_subkeys
        end.to_not change { Excavator.count }
      end
    end
    context 'permit' do
      # %i[RequestNumber SequenceNumber RequestType DateTimes ServiceArea digsite_info].each do |param|
      #  it { is_expected.to permit(param).for(:create) }
      # end
      xit {
        is_expected.to permit(
          :RequestNumber, :SequenceNumber, :RequestType,
          DateTimes: :ResponseDueDateTime,
          ServiceArea: [PrimaryServiceAreaCode: [:SACode],
                        AdditionalServiceAreaCodes: [SACode: []]],
          Excavator: [:CompanyName, :CrewOnsite,
                      Address: %i[Address City State Zip]]
        ).for(:create, params: @correct_json_data)
      }
    end
  end
end
