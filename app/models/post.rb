class Post < ApplicationRecord
  belongs_to :user
  belongs_to :poster_ip, optional: true
  has_many :ratings
  validates_presence_of :header, :content, length: { minimum: 3 }
  before_create :add_poster_ip

  def average_rating
    return -1 if ratings.empty?

    ratings.inject(0.0) { |sum, rating| sum + rating.value } / ratings.size
  end

  def add_poster_ip
    poster_ip = PosterIp.find_or_initialize_by(ip: ip)
    return if !poster_ip.new_record? && poster_ip.user_ids.include?(user_id.to_s)

    poster_ip.user_ids = poster_ip.user_ids << user_id.to_s
    poster_ip.user_logins = poster_ip.user_logins << user.login
    poster_ip.save
  end
end
