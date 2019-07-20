# frozen_string_literal: true

class Track < ApplicationRecord
  belongs_to :artist
  belongs_to :album

  # validations
  validates :title, presence: true
end
