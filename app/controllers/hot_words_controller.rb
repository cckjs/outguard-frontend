class HotWordsController < ApplicationController
  layout 'app'
  def index
    @hot_words = HotWord.where data_date: Time.now.strftime("%Y%m%d")
  end
end
