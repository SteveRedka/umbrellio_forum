FactoryBot.define do
  factory :rating do
    value 3
    association :post, factory: :post
  end
end
