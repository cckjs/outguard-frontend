class WebPagesController < ApplicationController
  before_action -> { @navbar = :wx_page }

  def index
     @pages = WebPage.all.order("fetchTime desc").page params[:page]
  end
end
