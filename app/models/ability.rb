class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.type == 'Owner'
      # Abilities for owners
      can :manage, [Owner]
      can :manage, [Restaurant, Category, Dish]
      can :index, [Restaurant, Category, Dish]
      can :show, [Restaurant, Category, Dish]
      can :search, [Dish] # Search for dishes
      can :create, Restaurant
      can :update, Category

    else
      user.type
      # Abilities for customers
      can :create, [Order]
      can :read, Order, user_id: user.id # View their own orders
      can :update, Order, user_id: user.id, order_status: 'cart'
      can :destroy, Order, user_id: user.id, order_status: 'cart'
      can :show,User
      can :update,Cart
      can :index, [Restaurant, Dish]
      can :search, [Dish]
      can :read, Category
      can :add_item,Cart
      can :destroy,Cart
      can :see_open, Restaurant, status: 'open' # See open restaurants
    end
  end
end
