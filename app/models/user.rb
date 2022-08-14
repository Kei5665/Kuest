class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_many :quests, dependent: :destroy
  has_many :ordered_quests, through: :quests, source: :post
  has_many :user_emblems, dependent: :destroy
  has_many :current_emblems,through: :user_emblems, source: :emblem

  def select_emblem(clear_num)

    begginer = Emblem.first
    intermediate = Emblem.second
    advanced = Emblem.last

    if  clear_num == 1
      new_emblem = self.user_emblems.build(emblem_id: begginer.id)
      new_emblem.save!
      number_needed = intermediate.limit_num  - clear_num
      "もう#{number_needed}回クリアでレベルアップ！"
    elsif clear_num < 3
      number_needed = intermediate.limit_num  - clear_num
      "もう#{number_needed}回クリアでレベルアップ！"
    elsif clear_num == 3
      new_emblem = self.user_emblems.build(emblem_id: intermediate.id)
      new_emblem.save!
      number_needed = advanced.limit_num  - clear_num
      "もう#{number_needed}回クリアでレベルアップ！"
    elsif clear_num < 5
      number_needed = advanced.limit_num  - clear_num
      "もう#{number_needed}回クリアでレベルアップ！"
    elsif clear_num == 5
      new_emblem = self.user_emblems.build(emblem_id: advanced.id)
      new_emblem.save!
      "レベルマックスです！"
    else
      "レベルマックスです！"
    end
  end
end
