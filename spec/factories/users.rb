FactoryBot.define do
  factory :user do
    username { 'garisah' }
    full_name { 'Glory Arisah' }
    sequence(:email) { |n| "garisah-#{n}@gmail.com" }
    password { 'garisah' }
  end
end
