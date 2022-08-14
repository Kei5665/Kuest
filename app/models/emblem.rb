class Emblem < ApplicationRecord
  has_one_attached :emblem_image
  has_many :user_emblems, dependent: :destroy
end
