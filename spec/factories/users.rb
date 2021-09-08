FactoryBot.define do
  factory :user do
    sequence (:email) { |n| "example_email_#{n}@domain.com" }
    password { 'password' }
  end
end
