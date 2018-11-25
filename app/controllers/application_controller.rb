class ApplicationController < ActionController::Base
  include JSONErrors

  protect_from_forgery unless: -> { request.format.json? }
end
