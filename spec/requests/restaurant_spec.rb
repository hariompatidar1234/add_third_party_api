require 'rails_helper'


RSpec.describe "Restaurants", type: :request do
  let(:user) { FactoryBot.create(:user, type: 'Owner') }
  # @owner = FactoryBot.create(:user, type: 'Owner')

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

  describe "POST /create" do
    context 'when params are correct' do
      byebug
      it 'is expected to create new restaurant successfully' do
        post '/restaurants', params: {restaurant: { name: "panchali", address: "viajy nagar" , status: "open"}}
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when params are not correct' do
      it 'is expected to render new template' do
        post '/restaurants', params:  { name: :nil}
        is_expected.to render_template(:new)
        # expect(response).to have_http_status(422)
      end
    end
  end
end
