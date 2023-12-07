# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    let(:state) { create(:state, symbol: 'CA') }
    let(:county1) { create(:county, name: 'county1', state: state) }
    let(:county2) { create(:county, name: 'county2', state: state) }

    before do
      county1
      county2
    end

    it 'returns with counties for the state' do
      get :counties, params: { state_symbol: 'CA' }, format: :json
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(json_response.map { |county| county['id'] }).to match_array([county1.id, county2.id])
    end
  end
end
