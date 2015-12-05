require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json

  protect_from_forgery with: :exception

protected
  def h(model_class, attribute = nil)
    if attribute
      model_class.human_attribute_name(attribute)
    else
      model_class.model_name.human
    end
  end
  helper_method :h

  def ok_url_or_default(default)
    params[:ok_url] || default
  end
end
