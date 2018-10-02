class ErrorsController < ApplicationController
  include JSONErrors

  def not_found
    render_404("Route was not found - #{request.url}")
  end

  def internal_error
    render_500
  end
end
