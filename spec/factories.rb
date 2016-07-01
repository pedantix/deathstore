FactoryGirl.define do
  factory :directive do
    content { Faker::Lorem.paragraph(2) }
    association(:user)
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
