# spec/factories/tracks.rb
FactoryBot.define do
  factory :track do
    title { Faker::Lorem.word }
  end
end
