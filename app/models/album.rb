# frozen_string_literal: true

# class that models an album
class Album < ApplicationRecord
  belongs_to :artist
  has_many :images

  validates :title, presence: true
end
