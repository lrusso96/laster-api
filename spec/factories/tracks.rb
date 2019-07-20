# frozen_string_literal: true

FactoryBot.define do
  factory :track do
    title { Faker::Lorem.word }
    association :artist, factory: :artist
    association :album, factory: :album
  end
end
