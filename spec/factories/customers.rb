FactoryBot.define do
  factory :customer do
    name          { Faker::Name.name }
    email         { Faker::Internet.email}
    password      { Faker::Internet.password(min_length: 8)}
  end
end
