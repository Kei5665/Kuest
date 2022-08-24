class Post < ApplicationRecord

  belongs_to :area
  
  validates :title, presence: true

  has_one_attached :image
  has_many :quests, dependent: :destroy

  def started?
    Time.current >= start_date
  end

  def still_open?
    Time.current < finish_date
  end
end
