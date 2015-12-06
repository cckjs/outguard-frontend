class AppsController < ApplicationController
  paginated_action only: [:docs, :my_docs]

  def index
  end

  def docs
    query = WebPageMetaData.joins(:page_ranks).joins(:page_keywords)
    query = query.where('json like ?', "%#{params[:title]}%") if (params[:title])
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
    page = MyPage.new(page_id: page_id)
    page.save
    respond_with page
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
    @res.append tmp
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
