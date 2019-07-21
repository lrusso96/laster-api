class Image < ApplicationRecord

  belongs_to :album

  # validations
  validates :url, presence: true
  validates :size, presence: true
end
