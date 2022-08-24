class Form::ProductCollection < Form::Base
  FORM_COUNT = 20 #ここで、作成したい登録フォームの数を指定
  attr_accessor :posts 

  def initialize(attributes = {})
    super attributes
    self.posts = FORM_COUNT.times.map { Post.new() } unless self.posts.present?
  end

  def set_scraped_data(posts)
    self.posts = posts
  end

  def posts_attributes=(attributes)
    self.posts = attributes.map { |_, v| Post.new(v) }
  end

  def save
    Post.transaction do
      self.posts.map do |post|
        if post.availability # ここでチェックボックスにチェックを入れている商品のみが保存される
          post.save
        end
      end
    end
      return true
    rescue => e
      return false
  end
end
