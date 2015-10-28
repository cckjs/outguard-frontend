class WxDocumentsController < ApplicationController
  before_action -> { @navbar = :wx_document }

  def index
    @docs = WxDocument.all.page params[:page]
  end
end
