require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:updated_params) { build(:user_params) }
  let(:invalid_updated_params) { build(:user_invalid_params) }

  describe 'GET #index' do
    let(:users) { create_list(:user, 2) }

    it 'populates an array of all users' do
      get :index

      expect(assigns(:users)).to eq(User.all)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'get user' do
      get :show, params: {id: user}

      expect(assigns(:user)).to eq user
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new user in the database' do
        expect { post :create, params: {user: updated_params } }.to change(User, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the user' do
        expect { post :create, params: { user: invalid_updated_params } }.to_not change(User, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'correct' do
        patch :update, params: { id: user, user: updated_params }
        expect(assigns(:user)).to eq user
      end

      it 'changes user attributes' do
        patch :update, params: { id: user.id, user: { name: 'new name', email: 'new@email.ru'} }
        user.reload
        expect(user.name).to eq 'new name'
        expect(user.email).to eq 'new@email.ru'
      end
    end

    context 'invalid attributes' do
      before do
        patch :update, params: { id: user, user: { name: 'new name', email: nil} }
      end

      it 'does not change user attributes' do
        user.reload
        expect(user.name).to eq "#{user.name}"
        expect(user.email).to eq "#{user.email}"
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'deletes user' do
      expect { delete :destroy, params: { id: user } }.to change(User, :count).by(-1)
    end
  end
end
