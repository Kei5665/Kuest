class AreasController < ApplicationController
  def index
    @areas = Area&.all
  end

  def show
    @area = Area.where(id:params[:id])[0]
    @posts = @area.posts

    @open_posts = Array.new
    @posts.each do |post|
      if post.start_date.present? && post.finish_date.present?
        if post.opened? && post.still_open?
          @open_posts << post
        end
      end
    end

  end
end
