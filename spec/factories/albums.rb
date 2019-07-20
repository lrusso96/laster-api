# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    title { Faker::Lorem.word }
    association :artist, factory: :artist
  end
end
