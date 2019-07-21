class Album < ApplicationRecord
  belongs_to :artist
  has_many :images

  validates :title, presence: true
end
