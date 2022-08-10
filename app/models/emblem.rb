class Emblem < ApplicationRecord
  has_one_attached :emblem_image

  belongs_to :user
  has_many :user_emblems, dependent: :destroy

end
