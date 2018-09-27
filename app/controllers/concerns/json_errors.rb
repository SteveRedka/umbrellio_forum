# This module adds functionality to return nice-looking error jsons
module JSONErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,       with: :render_404
    rescue_from ActionController::ParameterMissing, with: :render_400

    def render_400(err)
      render_errors(err, 400)
    end

    def render_404(err)
      render_errors(err, 404)
    end

    def render_500(err)
      render_errors(err, 500)
    end

    def render_errors(messages = ['Internal server error'],
                      status = status)
      result = { 'error': messages }
      render json: result, status: status
    end
  end
end
