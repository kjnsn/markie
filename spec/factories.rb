FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              "password"
    password_confirmation "password"
  end

  factory :bookmark do
    title "A webpage"
    url "http://example.com"
    user
  end
end
