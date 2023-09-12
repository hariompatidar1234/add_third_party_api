User.create(name:"hariom patidar",email:"hariom@123gmail.com",password:"hariom@123",type:"Owner")
User.create(name:"sachin paidar",email:"sachin@123gmail.com",password:"sachin@123",type:"Customer")
User.create(name:"devendra patidar",email:"devendra@123gmail.com",password:"devendra@123gmail.com",type:"Customer")


Category.create(name:"Indian")
Category.create(name:"Chines")
Category.create(name:"South Indian")

Restaurant.create(name:"gurukripa",address:"sarwate",status:"open",user_id:1)
Restaurant.create(name:"apna sweet",address:"vijay nagar",status:"open",user_id:1)
Restaurant.create(name:"lakshmi",address:"bangali",status:"closed",user_id:1)


Dish.create(name:"paneer",price:110,restaurant_id:1,category_id:1)
Dish.create(name:"dal",price:100,restaurant_id:1,category_id:1)
Dish.create(name:"dal",price:80,restaurant_id:2,category_id:1)
Dish.create(name:"dal",price:90,restaurant_id:3,category_id:1)


Dish.create(name:"Manchurian",price:50,restaurant_id:1,category_id:2)
Dish.create(name:"Manchurian",price:70,restaurant_id:2,category_id:2)
Dish.create(name:"Manchurian",price:90,restaurant_id:3,category_id:2)
Dish.create(name:"Noodles",price:60,restaurant_id:1,category_id:2)
Dish.create(name:"Momos",price:90,restaurant_id:2,category_id:2)