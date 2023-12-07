# frozen_string_literal: true

require 'rails_helper'

describe 'State' do
  context 'when I create a State' do
    it 'does not fail' do
      expect { create(:state) }.not_to raise_error
    end

    it 'std_fips_code is correct' do
      expect(create(:state, fips_code: 7).std_fips_code).to eq '07'
    end
  end
end
