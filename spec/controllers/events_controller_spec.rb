# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #index' do
    context 'without filter' do
      it 'assigns all events' do
        event1 = create(:event)
        event2 = create(:event)
        get :index
        expect(assigns(:events)).to match_array([event1, event2])
      end
    end

    context 'with filter by state-only' do
      it 'assigns filtered events' do
        state = create(:state)
        county1 = create(:county, state: state)
        event1 = create(:event, county: county1)

        get :index, params: { 'filter-by' => 'state-only', 'state' => state.symbol }

        expect(assigns(:events)).to match_array([event1])
      end
    end

    context 'with filter by county' do
      it 'assigns filtered events' do
        state = create(:state)
        county1 = create(:county, state: state)
        event1 = create(:event, county: county1)

        get :index, params: { 'filter-by' => 'county', 'state' => state.symbol, 'county' => county1.fips_code }

        expect(assigns(:events)).to match_array([event1])
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event to @event' do
      event = create(:event)

      get :show, params: { id: event.id }

      expect(assigns(:event)).to eq(event)
    end
  end
end
