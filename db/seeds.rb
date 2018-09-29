# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

system 'rails server -d'
uri = 'http://127.0.0.1:3000/'
posts_path = uri + 'api/posts/'
post_request = { post: { header: 'why', content: 'what' },
                 user: { login: 'bark', ip: '127.0.0.9' } }
                 byebug
HTTP.post(posts_path, params: post_request)

# Create users
# Ensure variety of ips
# Create posts
# Create ratings

system 'kill -INT $(cat tmp/pids/server.pid)'
