require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }

  describe 'GET #index' do
    context 'when user is admin' do
      before { sign_in admin_user }

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end

      it 'assigns required instance variables' do
        get :index
        expect(assigns(:total_users)).to be_present
        expect(assigns(:total_coffee_records)).to be_present
        expect(assigns(:today_records)).to be_present
      end
    end

    context 'when user is not admin' do
      before { sign_in user }

      it 'redirects to root_path' do
        get :index
        expect(response).to redirect_to(root_path)
      end

      it 'sets alert message' do
        get :index
        expect(flash[:alert]).to eq('管理者権限が必要です')
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end