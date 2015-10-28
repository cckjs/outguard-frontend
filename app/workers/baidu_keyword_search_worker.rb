class BaiduKeywordSearchWorker

  def perform(keyword)
    page_num = 2

    datas = parser_search_content "http://www.baidu.com/s?ie=utf-8&f=3&rsv_bp=0&rsv_idx=1&tn=baidu&wd=#{URI.escape(keyword)}", keyword, true
  end

  def parser_search_content(search_url, wd, pl = false)
    datas = Wombat.crawl do
      base_url search_url
      search_content "css=div[class*='result c-containe']", :iterator do
        keyword "#{wd}"
        engine "baidu"
        crawl_at "#{Time.now}"
        url({ xpath: ".//a[1]/@href" })
        title  "xpath=./h3/a"
        description  "xpath=.//div[@class='c-abstract']"
      end
      page_links "xpath=//div[@id='page']/a/span[@class='pc']/../@href", :list if pl
    end
    datas
  end
end