class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    can :manage, User
    can :login, User
    can :read, [Dish, Category, Restaurant, Order]
    if user.type == 'Owner'
      can :manage, [Restaurant, Category, Dish]
      can :my_restaurants_list, Restaurant
    elsif user.type == 'Customer'
      can :manage, Cart
      can :manage, Order
      can :manage, CartItem
      can :manage, OrderItem
    end
    nil unless user.type == 'Owner' or user.type == 'Customer'
  end
end
