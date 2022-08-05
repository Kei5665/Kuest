class Scraping
  require 'mechanize'

  agent = Mechanize.new
  page = agent.get("https://www.walkerplus.com/event_list/ar0313106/taito/")
  elements = page.search('.m-mainlist-item__img')
  urls = []

  # aタグをすべて抽出し詳細ページのURLを抽出
  elements.each do |ele|
    urls << ele.get_attribute(:href)
  end

  # 抽出した詳細ページURLにアクセスし、データ取得
  urls.each do |url|
    detail_page = agent.get(url + "data.html")
    price_page = agent.get(url + "price.html")

    p "タイトル: #{detail_page.at('.m-detailheader-heading__ttl')&.inner_text}"
    p "開催場所: #{detail_page.search('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[1]/td')&.inner_text.gsub(/[\r\n]/,"").gsub(" ", "").delete("[地図]")}"
    p "開催日: #{detail_page.search('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[3]/td')&.inner_text.gsub(/[\r\n]/,"").gsub(" ", "")}"
    p "開催時間: #{detail_page.search('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[4]/td')&.inner_text.gsub(/[\r\n]/,"").gsub(" ", "")}"
    p "住所: #{detail_page.search('/html/body/div/div[1]/main/section[1]/div[4]/table/tr[7]/td')&.inner_text}"
    p "金額: #{price_page.at('.m-infotable__td')&.inner_text}"

  end
end
