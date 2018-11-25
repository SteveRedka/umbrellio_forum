module Users
  # Handles #list_trolls in users_controller.rb
  # Returns hash with ips as keys and array of logins as values
  # Example:
  # { '127.0.0.1': ['admin'],
  #   '8.8.8.8': ['new_user', 'other_user'] }
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
