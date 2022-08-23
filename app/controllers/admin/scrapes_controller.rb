class Admin::ScrapesController < ApplicationController
  def create
    data = Scraping.new
    posts = data.scrape(params[:page_number],params[:area_name],params[:area_num])

    flash.now[:success] = "スクレイピングが成功しました！"
    render turbo_stream: turbo_stream.replace(
      'scrapes',
      partial: 'admin/posts/after_scrapes',
      locals: { posts: posts },
    )
  end
end
