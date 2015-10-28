class HtmlCrawlWorker

  def perform(search_result_id)
    return unless search_result_id
    search_result = SearchResult.find_by(id: search_result_id)
    return unless search_result

    datas = Wombat.crawl do
      base_url "#{search_result.url}"
      search_result do
        id "#{search_result.id}"
        keyword "#{search_result.keyword}"
      end
      url "#{search_result.url}"
      keywords "xpath=//meta[@name='keywords']/@content"
      crawl_at Time.new.iso8601
      title  "xpath=//title"
      description  "xpath=//meta[@name='description']/@content"
      body "xpath=//body", :html
    end
    push_datas datas if datas
  end

  def push_datas(datas)
    conn = build_connection
    conn.post( "#{Project.baidu_push_url}/html_content" ) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = datas.to_json
    end
  end

  def build_connection
    @conn ||= Faraday.new do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.response :raise_error
      faraday.adapter  Faraday.default_adapter
    end
  end

end