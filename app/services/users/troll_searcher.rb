module Users
  # Handles #list_trolls in users_controller.rb
  class TrollSearcher
    def call
      troll_ips = PosterIp.joins(:users)
                          .group('poster_ips.id')
                          .having('COUNT(poster_ips_users) > 1')
                          .map(&:ip)
      result = {}
      PosterIp.includes(:users)
              .where('poster_ips.ip in (?)', troll_ips).each do |pi|
        result[pi.ip] = pi.users.map(&:login)
      end
      result
    end
  end
end
