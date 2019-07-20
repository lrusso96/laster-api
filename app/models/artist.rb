# frozen_string_literal: true

class Artist < ApplicationRecord
  # validations
  validates :name, presence: true
end
