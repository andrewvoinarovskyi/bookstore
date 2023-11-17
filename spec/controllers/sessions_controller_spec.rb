require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #new' do
    context 'when user is not logged in' do
      it 'returns a successful response' do
        get :new
        expect(response).to be_successful
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when user is already logged in' do
      before { log_in(user) }

      it 'redirects to the root path' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs in the user' do
        post :create, params: { email: user.email, password: user.password }
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to the root path' do
        post :create, params: { email: user.email, password: user.password }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 'does not log in the user' do
        post :create, params: { email: 'invalid@example.com', password: 'invalid_password' }
        expect(session[:user_id]).to be_nil
      end

      it 'renders the new template' do
        post :create, params: { email: 'invalid@example.com', password: 'invalid_password' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the user' do
      log_in user
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the root path' do
      log_in user
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
