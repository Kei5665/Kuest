class Scraping
  require 'mechanize'
  require 'google_maps_service'

  def scrape(page_num,area_name,area_num)
    posts = []

    gmap = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_KEY'])

    agent = Mechanize.new
    page = agent.get("https://www.walkerplus.com/event_list/ar03131#{area_num}/#{area_name}/#{page_num}.html")
    elements = page.search('.m-mainlist-item__img')
    urls = []

    # aタグをすべて抽出し詳細ページのURLを抽出
    elements.each do |ele|
      urls << ele.get_attribute(:href)
    end

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
      formal_url = detail_page.at('.is-more')&.get_attribute(:href)

      p "#{detail_page.at('.m-detailheader-heading__ttl')&.inner_text}"
      p "#{detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[1]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")&.delete("[地図]")}"
      p "#{detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[3]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")}"
      p "#{detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[4]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")}"
      p "#{detail_page.at('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[7]/td')&.inner_text&.gsub(/[\r\n]/,"")&.gsub(" ", "")}"
      p "#{price_page.at('.m-infotable__td')&.inner_text}"
      p "#{detail_page.at('.is-more')&.get_attribute(:href)}"

      post = Post.new
      post.url = formal_url
      post.title = title
      post.place = place
      post.date = date
      post.address = address
      post.time = time
      post.price = price

      if address.present? && gmap.geocode(address).present?
        comp = gmap.geocode(address)
        post.latitude = comp[0][:geometry][:location][:lat]
        post.longitude = comp[0][:geometry][:location][:lng]

        area = Area.where(spelling: area_name)[0]
        post.area_id = area.id

        posts.push(post)
        
        sleep(1)
      else
        next
      end

    end

    posts

  end
end
