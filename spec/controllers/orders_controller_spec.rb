require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'when the user is authenticated' do
      before do
        log_in user
      end

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns the user\'s orders to @orders' do
        order1 = FactoryBot.create(:order, user: user)
        order2 = FactoryBot.create(:order, user: user)

        get :index
        expect(assigns(:orders)).to match_array([order1, order2])
      end
    end

    context 'when the user is not authenticated' do
      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
