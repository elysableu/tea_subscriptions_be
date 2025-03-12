class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: ErrorSerializer.format_error(e.message), status: :not_found
  end
end
