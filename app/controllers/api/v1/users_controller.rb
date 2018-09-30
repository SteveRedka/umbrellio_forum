class Api::V1::UsersController < ApplicationController
  def list_trolls
    # List ips which had multiple authors posting from them
    # @ip_users = {}
    # @posts = Post.all.includes(:user)
    # @posts.each do |pst|
    #   ip = pst.ip
    #   login = pst.user.login
    #   if @ip_users[ip]
    #     @ip_users[ip] << login unless @ip_users[ip].include?(login)
    #   else
    #     @ip_users[ip] = [login]
    #   end
    # end
    # @ip_users = @ip_users.select { |_key, val| val.length > 1 }
    # render json: @ip_users

    @poster_ips = PosterIp.all.select { |pip| pip.user_ids.length > 1 }
    render json: @poster_ips, only: %i[ip user_logins]
  end
end
