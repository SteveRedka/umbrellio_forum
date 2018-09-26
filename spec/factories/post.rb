FactoryBot.define do
  factory :post do
    header 'header'
    content 'content'
    association :user, factory: :user
  end
end
