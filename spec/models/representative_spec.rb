# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

RSpec.describe Representative do
  context 'when I add representatives once to the site' do
    existing_rep = described_class.create(name: 'John Doe', ocdid: '1234', title: 'Supreme Leader')
    rep = OpenStruct.new
    rep.officials = [OpenStruct.new(name: 'John Doe')]
    rep.offices = [OpenStruct.new(name: 'Supreme Leader', division_id: '1234', official_indices: [0])]
    reps = described_class.civic_api_to_representative_params(rep)
    it 'contains one entry' do
      expect(reps.length).to eq(1)
    end

    it 'matches with the existing id' do
      expect(reps.first.id).to eq(existing_rep.id)
    end
  end

  context 'when I create a representative entry' do
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: 'Berkeley')

    described_class.civic_api_to_representative_params(result)

    rep = described_class.first

    it 'has the fields ocdid' do
      expect { rep.ocdid }.not_to raise_error
    end

    it 'has the fields address' do
      expect { rep.address }.not_to raise_error
    end

    it 'has the fields political_party' do
      expect { rep.political_party }.not_to raise_error
    end

    it 'has the fields photo_url' do
      expect { rep.photo_url }.not_to raise_error
    end
  end
end
