# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    # a little comment
    sequence(:name) { |n| "pet_#{n}" }
  end
end
