class Admin::ScrapesController < ApplicationController
  def create
    data = Scraping.new
    data.scrape(params[:page_number],params[:area_name],params[:area_num])
    redirect_to admin_posts_path, success: "スクレピングに成功しました！"
  end
end
