module Users
  # Handles #list_trolls in users_controller.rb
  # Returns hash with ips as keys and array of logins as values
  # Example:
  # { '127.0.0.1': ['admin'],
  #   '8.8.8.8': ['new_user', 'other_user'] }
  class TrollSearcher
    def call
      troll_ips = PosterIp.joins(:users)
                          .where(ip: PosterIp.select('ip')
                                             .joins(:users)
                                             .group('poster_ips.id')
                                             .having('COUNT(poster_ips_users) > 1'))
                          .select('users.login, poster_ips.ip')

      result = Hash.new { |ip, users| ip[users] = [] }
      troll_ips.to_a.each do |troll_ip|
        result[troll_ip['ip']] << troll_ip['login']
      end

      result
    end
  end
end
