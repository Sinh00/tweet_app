FactoryBot.define do
  factory :like do
    association :post
    # postのfactoryでもassociation :userしているため、二重に生成しないようにpostのuserを参照
    user { post.user }
  end
end
