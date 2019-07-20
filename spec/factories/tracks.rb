# frozen_string_literal: true

FactoryBot.define do
  factory :track do
    title { Faker::Lorem.word }
    artist { Faker::Lorem.word }
  end
end
