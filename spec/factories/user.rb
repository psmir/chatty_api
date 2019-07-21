FactoryBot.define do
  sequence(:email)    { |n| "email_#{n}@local.test" }
  sequence(:password) { SecureRandom.hex(10) }

  factory :user do
    email                 { generate :email }
    password              { generate :password }
    password_confirmation { password }
    role                  { 'user' }
  end
end
