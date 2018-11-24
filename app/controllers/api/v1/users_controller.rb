class Api::V1::UsersController < ApplicationController
  def list_trolls
    troll_ips = PosterIp.joins(:users)
                        .group('poster_ips.id')
                        .having('COUNT(poster_ips_users) > 1')
                        .map(&:ip)
    @result = {}
    PosterIp.includes(:users)
            .where('poster_ips.ip in (?)', troll_ips)
            .each do |pi|

      @result[pi.ip] = pi.users.map(&:login)
    end
    render json: @result
  end
end
