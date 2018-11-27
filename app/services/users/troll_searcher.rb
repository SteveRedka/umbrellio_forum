module Users
  # Handles #list_trolls in users_controller.rb
  # Returns hash with ips as keys and array of logins as values
  # Example:
  # { '127.0.0.1': ['admin'],
  #   '8.8.8.8': ['new_user', 'other_user'] }
  class TrollSearcher
    def call
      awful_raw_sql = <<-SQL
        SELECT  users.login, poster_ips.ip
        FROM poster_ips
        JOIN poster_ips_users ON poster_ips_users.poster_ip_id = poster_ips.id
        JOIN users ON users.id = poster_ips_users.user_id
        WHERE poster_ips.ip IN (
          SELECT poster_ips.ip
          FROM poster_ips
          JOIN poster_ips_users ON poster_ips_users.poster_ip_id = poster_ips.id
          JOIN users ON users.id = poster_ips_users.user_id
          GROUP BY poster_ips.id
          HAVING (COUNT(poster_ips_users) > 1)
          )
      SQL
      troll_ips = ActiveRecord::Base.connection.execute(awful_raw_sql)

      result = Hash.new { |ip, users| ip[users] = [] }
      troll_ips.to_a.each do |troll_ip|
        result[troll_ip['ip']] << troll_ip['login']
      end

      result
    end
  end
end
