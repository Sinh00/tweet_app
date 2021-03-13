FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}" }
    sequence(:email) { |n| "TEST_EMAIL#{n}@example.com" }
    sequence(:password) { |n| "TEST_PASSWORD#{n}" }
  end
end