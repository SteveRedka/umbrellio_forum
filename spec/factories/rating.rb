FactoryBot.define do
  factory :rating do
    value 3
    association :user, factory: :user
    association :post, factory: :post
  end
end
