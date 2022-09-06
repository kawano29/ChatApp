class Room < ApplicationRecord
  has_many :likes

  validates :name, presence: true
end
