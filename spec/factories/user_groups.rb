FactoryBot.define do
  factory :user_group do
    group
    user
    role { 1 }
  end
end
