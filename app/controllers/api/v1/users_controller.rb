class Api::V1::UsersController < ApplicationController
  def list_trolls
    @poster_ips = PosterIp.all.select { |pip| pip.user_ids.length > 1 }
    render json: @poster_ips, only: %i[ip user_logins]
  end
end
