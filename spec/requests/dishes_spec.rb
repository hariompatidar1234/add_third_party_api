require 'rails_helper'

RSpec.describe "Dishes", type: :request do
  let(:user) { FactoryBot.create(:owner, type: 'Owner') }
  let(:restaurant) {FactoryBot.create(:restaurant , user_id: user.id)}
  let(:restaurant1) {FactoryBot.create(:restaurant , user_id: user.id)}
  let(:category) {FactoryBot.create(:category)}
  let(:dish) {FactoryBot.create(:dish, category_id: category.id , restaurant_id: restaurant.id)}
  let(:dish1) {FactoryBot.create(:dish, category_id: category.id , restaurant_id: restaurant.id)}

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
    current_user = controller.current_user

    # @restaurant = FactoryBot.create(:restaurant , user_id: user.id)
    # @restaurant1 = FactoryBot.create(:restaurant , user_id: user.id)
    # @category = FactoryBot.create(:category)
    # @dish = FactoryBot.create(:dish, category_id: @category.id , restaurant_id: @restaurant.id)
    # @dish1= FactoryBot.create(:dish, category_id: @category.id , restaurant_id: @restaurant1.id)
  end


  describe 'GET /dishes' do
    it 'returns with filtered dishes for a restaurant' do
      get "/dishes/?restaurant_id = #{restaurant.id}"
      expect(response).to have_http_status(:ok)
    end
    it 'returns dishes filtered by category_id' do
      get "/dishes?category_id=#{category.id}"
      expect(response).to have_http_status(:ok)
    end
    it 'returns dishes filtered by name' do
      get '/dishes?name=paneer'
      expect(response).to have_http_status(:ok)
    end
    it 'paginates dishes' do
      get '/dishes?page=2'
      expect(response).to have_http_status(:ok)
    end
  end


  describe 'GET #new' do
    it 'renders new template' do
      get '/dishes/new'
      is_expected.to render_template(:new)
    end
  end


  describe 'POST /dishes' do
    it 'creates a dish for owners' do
      # byebug
      post '/dishes',params: { dish: { name: 'paneer',price: 90,  category_id: category.id, restaurant_id: restaurant.id } }
      expect(response).to redirect_to dish_path(dish)

    end
    it 'returns an error for other owner trying to create a dish' do
      post '/dishes',
           params: { name: 'Dish Name', price: 9.99, restaurant_id: restaurant1.id, category_id: category.id }
      expect(response).to have_http_status(:unauthorized)
    end
    it 'returns an error for invalid dish creation' do
      post '/dishes', params: { name: nil, price: nil, restaurant_id: restaurant1.id, category_id: category.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /dishes/:id' do
    it 'shows a dish ' do
      get "/dishes/#{dish.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #edit/id' do
    it 'renders edit template' do
      get "/dishes/#{dish.id}/edit"
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT /update/id" do
    context "with valid parameters" do
      it "updates the requested Category" do
        put "/dishes/#{dish.id}" , params: { dish: { name: 'paneer',price: 90,  category_id: category.id, restaurant_id: restaurant.id } }
        dish.reload
        expect(response).to redirect_to dish_path(dish)
      end
    end

    context "with invalid parameters" do
      it "renders a response status and edit template" do
        put "/dishes/#{dish.id}" , params: { dish: { name: nil ,price: nil,  category_id: category.id, restaurant_id: restaurant.id } }
        is_expected.to render_template(:edit)
        expect(response).to have_http_status(422)
      end
    end


    context "with invalid parameters" do
     let(:user1) { FactoryBot.create(:owner, type: 'Owner') }
      it "renders a response status and edit template" do
       sign_in user1
       put "/dishes/#{dish.id}" , params: { dish: { name: nil ,price: nil,  category_id: category.id, restaurant_id: restaurant.id } }
        expect(response).to redirect_to dish_path(dish)
      end
    end
  end

  describe "DELETE /destory/id" do
    context " owner delete  own restaurant dish" do
      it "destroys the requested destory" do
        delete "/dishes/#{dish.id}"
         expect(response).to redirect_to root_path
      end
    end

     context "unatherized owner delete restaurant" do
     let(:user1) { FactoryBot.create(:owner, type: 'Owner') }
      it "destroys the requested category" do
       sign_in user1
        delete "/dishes/#{dish.id}"
         expect(response).to redirect_to dish_path(dish)
      end
    end
  end

  describe 'GET /dishes/owner_dishes' do
    it 'show owner dishes filter with dishe name ' do
      get '/dishes/owner_dishes', params: { name: 'panner' }
      expect(response).to have_http_status(:ok)
    end
    it 'show owner dishes filter with category id ' do
      get '/dishes/owner_dishes', params: { category_id: 1}
      expect(response).to have_http_status(:ok)
    end
  end
end
