class Api::V1::UsersController < ApplicationController
  def list_trolls
    @troll_ips = Users::TrollSearcher.new.call
    render json: @troll_ips
  end
end
