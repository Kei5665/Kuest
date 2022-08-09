class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_many :quests, dependent: :destroy
  has_many :ordered_quests, through: :quests, source: :post
  has_many :emblems, dependent: :destroy
  has_many :user_emblems, dependent: :destroy
  has_many :current_emblems,through: :user_emblems, source: :emblem

  def select_emblem(clear_num)

    begginer = Emblem.first
    intermediate = Emblem.second
    advanced = Emblem.last

    if  clear_num == 1
      self.user_emblems.build(emblem_id: begginer.id)
    elsif clear_num == 3
      self.user_emblems.build(emblem_id: intermediate.id)
    elsif clear_num == 5
      self.user_emblems.build(emblem_id: advanced.id)
    elsif
      return
    end
  end
end
