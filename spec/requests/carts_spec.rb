require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let(:user) { FactoryBot.create(:owner, type: 'Owner') }
  let(:user2) { FactoryBot.create(:owner, type: 'Owner') }
  let(:user1) { FactoryBot.create(:customer, type: 'Customer') }
  let(:restaurant) {FactoryBot.create(:restaurant , user_id: user.id)}
  let(:restaurant1) {FactoryBot.create(:restaurant , user_id: user2.id)}
  let(:category) {FactoryBot.create(:category)}
  let(:dish) {FactoryBot.create(:dish, category_id: category.id , restaurant_id: restaurant.id)}
    let(:dish1) {FactoryBot.create(:dish, category_id: category.id , restaurant_id: restaurant1.id)}
  let!(:cart) { FactoryBot.create(:cart, user_id: user1.id) }
  let!(:cartitem) {  FactoryBot.create(:cart_item, cart_id: cart.id, dish_id: dish.id)}

  before do
    sign_in user1
    allow(controller).to receive(:current_user).and_return(user1)
    current_user = controller.current_user
  end

  describe "GET /index" do
    it "renders the index template" do
      get "/carts"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end


  describe 'POST /carts' do
     it 'add cart item in the cart' do
       post '/carts', params: { quantity: 5, dish_id: dish.id }
        expect(flash[:notice]).to eq('CartItem added to cart successfully!')
     end
     it 'returns an error for invalid cart creation' do
       post '/carts', params: { quantity: nil, dish_id: dish.id }
       expect(flash[:alert]).to eq('Error: CartItem could not be added to cart.')
     end
     it 'returns an error for invalid cart creation' do
       post '/carts', params: { quantity: 6, dish_id: 9999 }
       expect(flash[:alert]).to eq('Error: Dish not found')
       expect(response).to redirect_to new_cart_path
     end
     it 'returns an error for invalid cart creation' do
      post '/carts', params: { quantity: 6, dish_id: dish1.id }
      expect(flash[:alert]).to eq('Error: CartItems could not be added to cart for a different restaurant.')
    end
   end

  describe 'GET /carts/:id' do
    it 'shows a cartitem ' do
       get "/carts/#{cartitem.id}"
       expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /carts/:id' do
     it 'update quantity in cart_item' do
       put "/carts/#{cartitem.id}", params: { quantity: 4 }
       expect(response).to redirect_to carts_path
     end
     it 'returns an error for a non-existent quantity in cart item' do
       put "/carts/#{cartitem.id}", params: { quantity: nil }
       expect(response).to have_http_status(:unprocessable_entity)
       expect(response). to redirect_to edit_cart_path(cartitem)
     end
   end
end
