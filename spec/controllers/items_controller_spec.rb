require 'rails_helper'
require 'active_support/all'

RSpec.describe Api::ItemsController, type: :controller do
  before(:all) do
    @correct_json_data = receive_correct_json
    @wrong_json_rook_keys = receive_wrong_json_root_keys
    @wrong_json_subkeys = receive_wrong_json_subkeys
    #@wrong_json_rook_keys = @correct_json_data.except(:)
  end

  describe 'route' do
    it { is_expected.to route(:post, '/api/items').to(action: :create, format: :json) }
  end

  describe "POST #create" do
    context 'get status' do
      it '201 with correct json' do
        post :create, params: @correct_json_data, as: :json
        expect(response).to have_http_status(201)
      end
      it '422 with wrong json(missed some root keys)' do
        post :create, params: @wrong_json_rook_keys, as: :json
        expect(response).to have_http_status(422)
      end
      it '422 with wrong json(missed some subkeys)' do
        post :create, params: @wrong_json_subkeys, as: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
