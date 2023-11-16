require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'logs in the new user' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(session[:user_id]).to be_present
      end

      it 'redirects to the root path' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:user, email: nil) }
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: FactoryBot.attributes_for(:user, email: nil) }
        expect(response).to render_template(:new)
      end
    end
  end
end
