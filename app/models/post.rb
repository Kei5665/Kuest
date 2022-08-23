class Post < ApplicationRecord

  belongs_to :area
  
  validates :title, presence: true

  has_one_attached :image
  has_many :quests, dependent: :destroy
end
