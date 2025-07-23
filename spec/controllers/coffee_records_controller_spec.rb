require 'rails_helper'

RSpec.describe CoffeeRecordsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let(:other_user) { create(:user) }
  let(:coffee_record) { create(:coffee_record, user: user) }

  before { sign_in user }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @coffee_records' do
      # テストデータを作成
      create(:coffee_record, user: user)
      get :index
      expect(assigns(:coffee_records)).to be_present
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: coffee_record.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new coffee_record' do
      get :new
      expect(assigns(:coffee_record)).to be_a_new(CoffeeRecord)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        coffee_record: {
          origin: 'エチオピア',
          bean_type: 'アラビカ',
          process_method: 'ウォッシュド',
          roast_level: 'ミディアムロースト',
          acidity_level: '中',
          body_level: '中',
          notes: 'テスト用のコーヒー'
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new coffee record' do
        expect do
          post :create, params: valid_params
        end.to change(CoffeeRecord, :count).by(1)
      end

      it 'redirects to coffee_records_path' do
        post :create, params: valid_params
        expect(response).to redirect_to(coffee_records_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a coffee record when roast_level is invalid' do
        expect do
          post :create, params: { coffee_record: {
            origin: 'エチオピア',
            bean_type: 'アラビカ',
            process_method: 'ウォッシュド',
            roast_level: '無効な焙煎度' # 無効な焙煎度を指定
          } }
        end.not_to change(CoffeeRecord, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:coffee_record) { create(:coffee_record, user: user) }

    context 'when user owns the record' do
      it 'deletes the coffee record' do
        expect do
          delete :destroy, params: { id: coffee_record.id }
        end.to change(CoffeeRecord, :count).by(-1)
      end

      it 'redirects to coffee_records_path' do
        delete :destroy, params: { id: coffee_record.id }
        expect(response).to redirect_to(coffee_records_path)
      end
    end

    context 'when admin user' do
      before { sign_in admin_user }

      it 'deletes the coffee record' do
        expect do
          delete :destroy, params: { id: coffee_record.id }
        end.to change(CoffeeRecord, :count).by(-1)
      end
    end

    context 'when other user' do
      before { sign_in other_user }

      it 'does not delete the coffee record' do
        expect do
          delete :destroy, params: { id: coffee_record.id }
        end.not_to change(CoffeeRecord, :count)
      end

      it 'redirects to coffee_records_path with alert' do
        delete :destroy, params: { id: coffee_record.id }
        expect(response).to redirect_to(coffee_records_path)
        expect(flash[:alert]).to eq('削除権限がありません')
      end
    end
  end
end
