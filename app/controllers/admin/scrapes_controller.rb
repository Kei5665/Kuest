class Admin::ScrapesController < Admin::BaseController
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
end
