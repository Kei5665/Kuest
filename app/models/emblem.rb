class Emblem < ApplicationRecord
  has_one_attached :emblem_image
  has_many :users, dependent: :destroy
end
