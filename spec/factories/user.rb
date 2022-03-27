FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::Lorem.sentence }
    email { Faker::Internet.email }
    age { Faker::Number.number(digits: 2) }
    dataset { {} }
  end

  factory :user_params, class: Hash do
    initialize_with do
      {
        name: Faker::Lorem.sentence,
        email: Faker::Internet.email,
        age: Faker::Number.number(digits: 2)
      }
    end
  end

  factory :user_invalid_params, class: Hash do
    initialize_with do
      {
        name: ''
      }
    end
  end
end
