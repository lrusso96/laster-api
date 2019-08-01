# frozen_string_literal: true

# class that models an artist
class Artist < ApplicationRecord
  # validations
  validates :name, presence: true
end
