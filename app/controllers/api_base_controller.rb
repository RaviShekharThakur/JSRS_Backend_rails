class ApiBaseController < ActionController::API
  before_action :set_active_storage_url_options

  def respond_with_error(error_message, code)
    render json: {
      status: {
        code: code,
        message: error_message
      }
    }, status: code
  end

  def respond_success_message(message, code)
    render json: {
      status: {
        code: code,
        message: message
      }
    }, status: code
  end

  def render_listing_success_response(records, serializer, options = {}, code = 200, message = "Success")
    render json: {
      data: serializer.new(records, options).serializable_hash[:data].map { |e| e[:attributes] },
      status: {
        code: code,
        message: message
      }
    }, status: code
  end


  def render_show_success_response(record, serializer, options = {}, code = 200, message = "Success")
    render json: {
      data: serializer.new(record, options).serializable_hash[:data][:attributes],
      status: {
        code: code,
        message: message
      }
    }, status: code
  end
  private

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = { host: request.base_url }
  end
end
