class Admin::ScrapesController < ApplicationController
  def create
    data = Scraping.new
    scraped_data = data.scrape(params[:page_number],params[:area_name],params[:area_num])

    product_collection = Form::ProductCollection.new
    product_collection.set_scraped_data(scraped_data)

    render turbo_stream: turbo_stream.replace(
      'scrapes',
      partial: 'admin/posts/after_scrapes',
      locals: { form: product_collection },
    )
  end

  def new
    @form = Form::ProductCollection.new
  end

  # def create
  #   @form = Form::ProductCollection.new(product_collection_params)

  #   if @form.save
  #     redirect_to root_path, notice: "投稿を登録しました"
  #   else
  #     flash.now[:alert] = "商品登録に失敗しました"
  #     render :new
  #   end

  # end

end
