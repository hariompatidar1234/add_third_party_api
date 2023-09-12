class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.type == 'Owner'
      # Abilities for owners
      can :manage, [Restaurant, Category, Dish]
      can :index, [Restaurant, Category, Dish]
      can :show, [Restaurant, Category, Dish]
      can :search, [Dish] # Search for dishes
      can :create, Restaurant
      can :update, Category
      can :manage,User

    else  
      user.type
      # Abilities for customers
      can :create, [Order,Cart]
      can :show,[User,Order,Cart]
      can :index, [Restaurant, Dish,Order]
      can :search, [Dish]
      can :read, Category
      can :destroy,[Cart,Order]
      can :see_open, Restaurant, status: 'open' # See open restaurants
    end
  end
end
