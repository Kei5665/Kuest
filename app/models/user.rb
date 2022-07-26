class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_many :posts, dependent: :destroy
  has_many :quests, dependent: :destroy
  has_many :ordered_quests, through: :quests, source: :post

end
