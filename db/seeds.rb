# seeds.rb

POSTS_COUNT = 200_000 + Post.count

def create_user_with_posts(posts_count, ip)
  user = User.create(login: Faker::Name.unique.name)
  posts_count.times do
    pst = user.posts.new(header: Faker::Lorem.sentence,
                            content: Faker::Lorem.paragraph(2),
                            ip: ip)

    pst.save(validate: false)

    if (Post.count % 1000).zero?
      puts "#{Post.count}/#{POSTS_COUNT} posts created"
    end

    # Create ratings for only 1% of posts
    create_some_ratings(pst) if rand(0...100) < 1
  end
end

def create_some_ratings(pst)
  rand(0..10).times do
    pst.ratings.create(value: rand(0..5))
  end
end

puts 'Creating normal users with their posts'
40.times do
  ip = Faker::Internet.unique.public_ip_v4_address
  create_user_with_posts(POSTS_COUNT / 100, ip)
end

puts 'Creating trolls and bots with their posts'
10.times do
  ip = Faker::Internet.unique.public_ip_v4_address
  6.times do
    create_user_with_posts(POSTS_COUNT / 100, ip)
  end
end
