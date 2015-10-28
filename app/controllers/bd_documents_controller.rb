class BdDocumentsController < ApplicationController
  before_action -> { @navbar = :bd_document }
  
  def index
  end

  def search
    @results = BaiduKeywordSearchWorker.new.perform params["keywords"]
  end
end
