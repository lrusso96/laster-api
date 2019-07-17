# frozen_string_literal: true

class Track < ApplicationRecord
  # validations
  validates :title, presence: true
end
