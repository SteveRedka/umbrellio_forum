FactoryBot.define do
  factory :rating do
    value { Random.new.rand(1..5) }
    association :post, factory: :post
  end
end
