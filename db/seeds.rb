# seeds.rb

POSTS_COUNT = 200_000
USERS_COUNT = 100
IPS_COUNT = 50

ips = Array.new(IPS_COUNT) { Faker::Internet.unique.public_ip_v4_address }

logins = Array.new(USERS_COUNT) { Faker::Name.unique.name }

puts 'Creating posts'
POSTS_COUNT.times do |counter|
  pst = Posts::PostCreateHandler.new(header: Faker::Lorem.sentence,
                                     content: Faker::Lorem.paragraph(2),
                                     login: logins.sample,
                                     ip: ips.sample).call

  if pst.id % 1000 == 3 # Rate only 0.1% of posts
    rand(0..10).times do
      Ratings::RateHandler.new(post_id: pst.id,
                               value: rand(1..5),
                               silent: true).call
    end
  end

  print "#{counter}/#{POSTS_COUNT}\r" if (counter % 10).zero?
end
