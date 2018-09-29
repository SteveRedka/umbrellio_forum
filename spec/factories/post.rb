FactoryBot.define do
  factory :post do
    header { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph(2) }

    association :user, factory: :user

    transient do
      ratings_count { 0 }
    end

    after(:create) do |pst, evaluator|
      create_list(:rating, evaluator.ratings_count, post: pst)
    end
  end
end
