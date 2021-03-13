FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "TEST_CONTENT#{n}" }

    # 関連するモデルも同時に作成してくれる
    association :user
  end
end