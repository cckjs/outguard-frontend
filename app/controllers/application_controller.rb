class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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
