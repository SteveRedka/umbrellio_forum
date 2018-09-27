FactoryBot.define do
  factory :post do
    header Faker::Lorem.sentence
    content Faker::Lorem.paragraph(2)
    association :user, factory: :user
  end
end
