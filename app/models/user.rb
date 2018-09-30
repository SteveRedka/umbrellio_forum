class User < ApplicationRecord
  has_many :posts
  has_many :poster_ips, through: :post
end
