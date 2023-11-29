require 'rails_helper'


RSpec.describe "Restaurants", type: :request do
  let(:user) { FactoryBot.create(:owner, type: 'Owner') }
  # @owner = FactoryBot.create(:user, type: 'Owner')
  let(:restaurant) {FactoryBot.create(:restaurant)}
  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
    current_user = controller.current_user
  end


  describe "GET /index" do
    it 'is search restaurant with name' do
      get '/restaurants', params: { name: 'panchali' }
        expect(response).to be_successful
    end

    it 'is search restaurant with address' do
      get '/restaurants' , params: {address: "indore"}
      expect(response).to be_successful
    end

    it 'is search restaurant with status' do
      get '/restaurants', params: {status: 'open'}
        expect(response).to be_successful
    end

    it 'it add pagination' do
      get '/restaurants' , params: {page: 2}
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    before do
      get '/restaurants/new'
    end
    it 'renders new template' do
      is_expected.to render_template(:new)
    end
  end

 describe "POST #create" do
    context 'when params are correct' do
      it 'creates a new restaurant' do
        post '/restaurants', params: { restaurant: { name: "panchali", address: "vijay nagar", status: "open" } }
        expect(response).to redirect_to(root_path)
        expect(flash[:message]).to eq('You Created Successfully!')
      end
    end
    context 'when params are not correct' do
      it 'renders the new template with unprocessable entity status' do
        post '/restaurants', params: { restaurant: { name: nil } }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show/:id' do
    context "with data available" do
      it 'render successfully restaurant data' do
        get "/restaurants/#{restaurant.id}"
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #edit/id' do
    it 'renders edit template' do
      put "/restaurants/#{restaurant.id}"
      expect(response).to render_template(:edit)
    end
  end
end
