FactoryBot.define do
  factory :user do
    login { Faker::Name.unique.name }
  end
end
