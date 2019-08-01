# frozen_string_literal: true

# class that models a track
class Track < ApplicationRecord
  belongs_to :artist
  belongs_to :album

  # validations
  validates :title, presence: true
end
