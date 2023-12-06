# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'GET #profile' do
    context 'when a user is logged in' do
      let(:user) do
        User.create!(provider: 1, uid: '123456', email: 'sample@berkeley.edu', first_name: 'Abby',
                     last_name: 'Road')
      end

      before do
        session[:current_user_id] = user.id
      end

      it 'assigns the user to @user' do
        get :profile
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'when no user is logged in' do
      before do
        get :profile
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
