class Track < ApplicationRecord
  # validations
  validates :title, presence: true
end
