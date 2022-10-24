FactoryBot.define do
  factory :pet do
    sequence(:name) { |n| "pet_#{n}" }
  end
end
