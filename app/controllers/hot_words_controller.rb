class HotWordsController < ApplicationController
  layout 'app'
  def index
    @search_date = params['data_date'] ? params['data_date'] : Time.now.strftime("%Y%m%d")
    @hot_words = HotWord.where("data_date = #{ @search_date }").select(:content, :url, :data_date).distinct
  end
end
