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

  def self.paginated_action(options = {})
    before_filter(options) do |controller|
      if request.headers['Range-Unit'] == 'items' &&
          request.headers['Range'].present?

        requested_from = nil
        requested_to = nil

        if request.headers['Range'] =~ /(\d+)-(\d*)/
          requested_from, requested_to = $1.to_i, ($2.present? ? $2.to_i : Float::INFINITY)
        end

        if (requested_from > requested_to)
          response.status = 416
          headers['Content-Range'] = "*/#{total_items}"
          render text: 'invalid pagination range'
          return false
        end

        @kp_per_page = requested_to - requested_from + 1
        @kp_page = requested_to / @kp_per_page + 1
      end
    end

    after_filter(options) do |controller|
      results = instance_variable_get("@#{controller_name}")
      if(results.length > 0)
        response.status = 206
        headers['Accept-Ranges'] = 'items'
        headers['Range-Unit'] = 'items'

        total_items = results.total_count
        current_page = results.current_page
        per = @kp_per_page

        requested_from = (results.current_page - 1) * per
        available_to = (results.length - 1) + requested_from

        headers['Content-Range'] = "#{requested_from}-#{available_to}/#{total_items < Float::INFINITY ? total_items : '*'}"
      else
        response.status = 204
        headers['Content-Range'] = "*/0"
      end
    end
  end

end
