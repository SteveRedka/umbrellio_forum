# This module adds functionality to return nice-looking error jsons
module JSONErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,       with: :render_404

    def render_404(err = ['Route not found'])
      render_errors(err, status: 404)
    end

    def render_422(err = ['Unprocessable entry'])
      render_errors(err, status: 422)
    end

    def render_500(err = ['Internal server error'])
      render_errors(err, status: 500)
    end

    def render_errors(messages = ['Internal server error'],
                      status: 500)
      result = { 'error': messages }
      render json: result, status: status
    end
  end
end
