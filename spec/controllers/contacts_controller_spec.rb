require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new contact' do
      get :new
      expect(assigns(:contact)).to be_a_new(Contact)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        contact: {
          name: 'テスト太郎',
          email: 'test@example.com',
          subject: 'テスト件名',
          message: 'これはテスト用のメッセージです。十分な長さがあります。',
          category: 'その他'
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new contact' do
        expect {
          post :create, params: valid_params
        }.to change(Contact, :count).by(1)
      end

      it 'redirects to contact_thanks_path' do
        post :create, params: valid_params
        expect(response).to redirect_to(contact_thanks_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a contact' do
        expect {
          post :create, params: { contact: { name: '' } }
        }.not_to change(Contact, :count)
      end

      it 'renders new template' do
        post :create, params: { contact: { name: '' } }
        expect(response).to render_template(:new)
      end
    end
  end
end