class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    can :manage, User
    can :login, User
    if user.type == 'Owner'
      # Abilities for owners
      can :manage, [Restaurant, Category, Dish]
      can :index, [Restaurant, Category, Dish, User, Order]
      can :show, [Restaurant, Category, Dish]
      can :search, [Dish] # Search for dishes
      can :create, Restaurant
      can :update, Category
      can :manage, User

    else
      
      # Abilities for customers
      can :create, [Order, Cart]
      can :show, [User, Order, Cart]
      can :index, [Restaurant, Dish, Order,Cart]
      can :search, [Dish]
      can :read, Category
      can :create,CartItem
      can :destroy, [Cart, Order]
     can :destroy_item, Cart
    end
  end
end 