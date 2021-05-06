FactoryGirl.define do
  factory :user, class: User do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    uid { Faker::Config.random.seed }
    provider { 'facebook' }
    avatar_url { 'https://picsum.photos/200/300' }
  end
end