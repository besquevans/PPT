class Board < ApplicationRecord
  validates :title, presence: true
  validates :intro, presence: true
end