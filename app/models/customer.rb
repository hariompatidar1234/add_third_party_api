class Customer < User
  has_one :cart ,  dependent: :destroy
  has_many :orders ,  dependent: :destroy

  after_create :create_cart
  def create_cart
    cart.create
  end
end
