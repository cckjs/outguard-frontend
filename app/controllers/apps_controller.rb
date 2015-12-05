class AppsController < ApplicationController

  def index
     @data = WebPageMetaData.first
     respond_with @data
  end

end
