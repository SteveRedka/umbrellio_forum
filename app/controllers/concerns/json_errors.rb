# This module adds functionality to return nice-looking error jsons
module JSONErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,       with: :render_404
    rescue_from ActionController::ParameterMissing, with: :render_400
    rescue_from ArgumentError,                      with: :render_400

    def render_400(err = ['Invalid parameter'])
      render_errors(err, 400)
    end

    def render_404(err = ['Route not found'])
      render_errors(err, 404)
    end

    def render_500(err = ['Internal server error'])
      render_errors(err, 500)
    end

    def render_errors(messages = ['Internal server error'],
                      status = 500)
      result = { 'error': messages }
      render json: result, status: status
    end
  end
end
