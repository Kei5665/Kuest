class Post < ApplicationRecord

  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validates :latlng, presence: true

  has_one_attached :image
  has_many :quests, dependent: :destroy
end
