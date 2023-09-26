class CartSerializer < ActiveModel::Serializer
  attributes :id, :customer_name, :customer_mail

  has_many :cart_items
  has_many :dishes, through: :cart_items

  def customer_name
    object.customer.name
  end

  def customer_mail
    object.customer.email
  end
end
