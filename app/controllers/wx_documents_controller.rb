class WxDocumentsController < ApplicationController
  before_action -> { @navbar = :wx_document }

  def index
    @docs = WxDocument.all.order("date desc").page params[:page]
  end
end
