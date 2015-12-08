class AppsController < ApplicationController
  paginated_action only: [:docs, :my_docs, :npy_docs]

  def index
  end

  def docs
    query = WebPageMetaData.joins(:page_ranks).joins(:page_keywords)
    query = query.where('json like ?', "%#{params[:title]}%") if params[:title] && !params[:title].empty?
    if (params[:order] && params[:order] == 'time')
      query = query.order('updated_at desc')
    end
    if (params[:order] && params[:order] == 'zn')
      query = query.order('page_rank.weight desc')
    end
    query = query.includes(:page_keywords)
    @apps= query.page(@kp_page).per(@kp_per_page)
    respond_with query_docs(@apps)
  end

  def my_docs
    query = WebPageMetaData.joins(:my_pages)
    query = query.where('json like ?', "%#{params[:title]}%") if (params[:title])
    query = query.order('my_pages.created_at desc')

    @apps= query.page(@kp_page).per(@kp_per_page)
    respond_with query_docs(@apps)
  end

  def add_my_doc
    page_id = params[:page_id]
    page = MyPage.find_or_initialize_by page_id: page_id
    page.save
    respond_with page
  end

  def remove_my_doc
    page_id = params[:page_id]
    page = MyPage.find_by page_id: page_id
    page.destroy if page
    respond_with page
  end

  def npy_docs
    @kp_page = 0 if @kp_per_page.nil?
    @kp_per_page = 5 if @kp_per_page.nil?
    @apps= query_npy(params['title'], (@kp_page-1) * @kp_per_page, @kp_per_page)
    @res = Array.new

    def @apps.total_count
      self['numFound']
    end

    def @apps.current_page
      self['start']/5 + 1
    end

    def @apps.length
      self['docs'].length
    end

    @apps['docs'].each do |map|
      tmp = Hash.new
      tmp['url'] = map['url']
      tmp['title'] = map['title']
      tmp['content'] = map['content'].strip.truncate(100)
      tmp['source'] = query_source(map['url'])
      tmp['updated_at'] = DateTime.parse(map['tstamp']).strftime('%Y-%m-%d %H:%M:%S').try(:sub, '2015-', '')
      tmp['id'], tmp['keywords'] = query_keywords_url map['url']
      @res.append tmp unless has_sensitive_words tmp['keywords']
      begin
      rescue
      end
    end
    respond_with @res
  end
end


private
def query_docs(docs)
  @arrs = JSON.parse(docs.to_json({include: :page_keywords}))
  @res = Array.new
  @arrs.each do |map|
    tmp = Hash.new
    json = JSON.parse(map['json'])
    tmp['id'] = map['id']
    tmp['updated_at'] = map['updated_at'].try(:sub, '2015-', '')
    tmp['url'] = map['url']
    tmp['title'] = json['title']
    tmp['content'] = json['body-news-content'].strip.truncate(100)
    tmp['source'] = query_source(tmp['url'])
    tmp['keywords'] = query_keywords(map['id'])
    @res.append tmp unless has_sensitive_words tmp['keywords']
    begin
    rescue
    end
  end
  @res
end

def query_source(url)
  rule = UrlWeightRule.where("'"+url+ "'"+" LIKE concat('"+'%%'+"',url,'"+'%%'+"')", "").try(:first)
  rule.nil? ? '' : rule.source
end

def query_keywords(page_id)
  keyword = PageKeyword.where(:page_id => page_id).first
  keyword.nil? ? '' : keyword.keywords.split(',')
end

def query_keywords_url(url)
  page = WebPageMetaData.find_by(url: url)
  return nil unless page
  keyword = page.page_keywords.first
  [page.id, keyword.nil? ? '' : keyword.keywords.split(',')]
end

def query_npy(title, start, rows)
  url = "http://139.129.99.173:8080/solr/collection1/select?q=女朋友,女友,女生,#{title}&start=#{start}&rows=#{rows}&wt=json&indent=true"
  res = RestClient.get URI.encode(url)
  json = JSON.parse res
  json['response']
end

def has_sensitive_words(keywords)
  return false unless keywords
  filter_words = FilterWord.all
  filter_words.each do |words|
    return true if keywords.include? words.word
  end
  return false
end