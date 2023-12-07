# frozen_string_literal: true

require 'rails_helper'
require 'securerandom'

describe 'User' do
  context 'when I create a user' do
    it 'has correct name' do
      expect(create(:user).name).to eq 'John Reese'
    end
  end

  context 'when I create a Google-user' do
    it 'can be found by find_google_user' do
      original_user = create(:user, :google_user, uid: 'GOOGLE-UUID')
      expect(User.find_google_user('GOOGLE-UUID')).to eq original_user
    end

    it 'has correct auth provicer' do
      expect(create(:user, :google_user).auth_provider).to eq 'Google'
    end
  end

  context 'when I create a Github-user' do
    it 'can be found by find_github_user' do
      original_user = create(:user, :github_user, uid: 'GITHUB-UUID')
      expect(User.find_github_user('GITHUB-UUID')).to eq original_user
    end

    it 'has correct auth provicer' do
      expect(create(:user, :github_user).auth_provider).to eq 'Github'
    end
  end
end
