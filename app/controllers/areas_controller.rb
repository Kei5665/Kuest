class AreasController < ApplicationController
  def index
    @areas = Area&.all
  end

  def show
    @area = Area.where(id:params[:id])[0]
    @posts = @area.posts
  end
end
