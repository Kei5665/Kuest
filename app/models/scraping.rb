class Scraping
  require 'mechanize'
  require 'google_maps_service'

  def scrape(page_num)


    gmap = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_KEY'])

    agent = Mechanize.new
    # page = agent.get("https://tokyoeast21.net/category/taito/")
    # elements = page.search('//*[@id="contentInner"]/main/article/div[2]/dl/dt/a')
    page = agent.get("https://www.walkerplus.com/event_list/ar0313106/taito/#{page_num}.html")
    elements = page.search('.m-mainlist-item__img')
    urls = []

    # aタグをすべて抽出し詳細ページのURLを抽出
    elements.each do |ele|
      urls << ele.get_attribute(:href)
    end

    # 東東京イベント情報
    # urls.each do |url|

    #   page = agent.get(url)
    #   title = page.at('.entry-title')&.inner_text

    #   src = page.search('.wp-block-image').at('img')['src'] # 商品画像
    #   puts src
    #   agent.get(src).save_as("../app/public/images/#{title}.jpg") # 保存する
    # end
    # walker plus
    urls.each do |url|

      page = agent.get(url)
      detail_page = agent.get(url + "data.html")
      price_page = agent.get(url + "price.html")

      title = detail_page.at('.m-detailheader-heading__ttl')&.inner_text
      place = detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[1]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")&.delete("[地図]")
      date = detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[3]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")
      time = detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[4]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")
      address = detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[7]/td')&.inner_text
      price = price_page.at('.m-infotable__td')&.inner_text
      body = page.search('/html/body/div[1]/div[1]/main/section[1]/div[3]/div[2]/div[2]/p')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")
      src = page.at('.m-detailmain__slide_item img[1]').get_attribute(:src)
      image = "https:" + src

      p "#{detail_page.at('.m-detailheader-heading__ttl')&.inner_text}"
      p "#{detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[1]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")&.delete("[地図]")}"
      p "#{detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[3]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")}"
      p "#{detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[4]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")}"
      p "#{detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[7]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")}"
      p "#{price_page.at('.m-infotable__td')&.inner_text}"
      p "#{page.search('/html/body/div[1]/div[1]/main/section[1]/div[3]/div[2]/div[2]/p')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")}"
      p "#{page.at('.m-detailmain__slide_item img[1]')}"

      post = Post.new
      post.title = title
      post.place = place
      post.date = date
      post.address = address
      post.time = time
      post.price = price
      post.body = body
      downloaded_image = URI.parse(image).open
      post.image.attach(io: downloaded_image, filename: "#{title}.jpg")

      if address.present? && gmap.geocode(address).present?
        comp = gmap.geocode(address)
        post.latlng = comp[0][:geometry][:location]
      end

      if post.valid?
        post.save
      else
        next
      end

      sleep(1)
    end

  end
end
