FactoryGirl.define do
  factory :user do
    email                 { generate(:email) }
    password              "password"
    password_confirmation "password"
  end

  factory :bookmark do
    title "A webpage"
    url "http://example.com"
    user
  end
end
