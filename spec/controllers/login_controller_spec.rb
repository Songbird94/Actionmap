# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'GET #login' do
    context 'when user is not logged in' do
      it 'renders the login template' do
        get :login
        expect(response).to render_template('login')
      end
    end

    context 'when user is already logged in' do
      before { session[:current_user_id] = 1 }

      it 'redirects to user profile path' do
        get :login
        expect(response).to redirect_to(user_profile_path)
      end
    end
  end

  describe 'GET #google_oauth2 or #github' do
    before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2] }

    it 'creates a new user for google_oauth2' do
      expect { get :google_oauth2 }.to change(User, :count).by(1)
    end

    it 'redirects to the root path after Google login' do
      get :google_oauth2
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #github' do
    before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github] }

    it 'creates a new user for github' do
      expect { get :github }.to change(User, :count).by(1)
    end

    it 'redirects to the root path after GitHub login' do
      get :github
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #logout' do
    it 'clears the session' do
      session[:current_user_id] = 1
      get :logout
      expect(session[:current_user_id]).to be_nil
    end

    it 'redirects to the root path' do
      get :logout
      expect(response).to redirect_to(root_path)
    end
  end
end
