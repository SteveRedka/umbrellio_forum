require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'POST /api/posts' do
    valid_post = { header: 'foo', content: 'bar' }
    valid_user = { login: 'author', ip: '0.0.0.0' }

    let!(:user) { create :user, login: valid_user[:login] }

    context 'with valid inputs' do
      it 'creates post' do
        expect do
          post(api_posts_path, params: { post: valid_post,
                                         user: valid_user })
        end.to change { Post.count }.by(1)
        expect(response).to have_http_status(200)
        expect(response.body).to include(valid_post[:header])
        expect(response.body).to include(valid_post[:content])
        expect(Post.last.user).to eq(user)
      end

      it 'creates new user if user with such login doesn`t exist yet' do
        expect do
          post(api_posts_path, params: { post: valid_post,
                                         user: { login: 'user_new' } })
        end.to change { User.count }.by(1).and change { Post.count }.by(1)
      end
    end

    context 'with invalid inputs' do
      context 'for users' do
        it 'doesn`t create post if user is missing' do
          expect do
            post(api_posts_path, params: { post: valid_post })
          end.to change { Post.count }.by(0)
          expect(response).to have_http_status(400)
        end
      end

      context 'for posts' do
        it 'doesn`t create post if post is missing' do
          expect do
            post(api_posts_path, params: { user: valid_user })
          end.to change { Post.count }.by(0)
          expect(response).to have_http_status(400)
        end

        it 'doesn`t create post if header is missing' do
          expect do
            post(api_posts_path, params: { post: { header: '',
                                                   content: 'foo' },
                                           user: valid_user })
          end.to change { Post.count }.by(0)
          expect(response).to have_http_status(400)
        end

        it 'doesn`t create post if content is missing' do
          expect do
            post(api_posts_path, params: { post: { header: 'header',
                                                   content: '' },
                                           user: valid_user })
          end.to change { Post.count }.by(0)
          expect(response).to have_http_status(400)
        end
      end
    end
  end

  describe 'POST /api/rate(:id)' do
    let!(:rateable) { create :post }

    it 'creates a rating' do
      expect do
        post(api_rate_path(rateable.id),
             params: { rating: { post_id: rateable.id, value: 3 } })
      end.to change { Rating.count }.by(1)
      expect(response).to have_http_status(200)
    end

    it 'changes average rating of a post' do
      post(api_rate_path(rateable.id),
           params: { rating: { post_id: rateable.id, value: 5 } })
      expect(response.body).to include('5.0')
      post(api_rate_path(rateable.id),
           params: { rating: { post_id: rateable.id, value: 4 } })
      expect(response.body).to include('4.5')
      expect(response).to have_http_status(200)
    end

    it 'handles concurrent requests properly'

    context 'invalid requests' do
      it 'doesn`t create rating if post with this id doesn`t exist' do
        expect do
          post(api_rate_path(rateable.id),
               params: { rating: { post_id: 9999, value: 3 } })
        end.to change { Rating.count }.by(0)
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /api/posts' do
    before do
      create_list(:post, 15, ratings_count: 1)
    end

    it 'lists top 10 posts' do
      get api_posts_path
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(10)
      expect(response).to have_http_status(200)
    end

    it 'lists average ratings' do
      get api_posts_path
      expect(response.body).to include('average_rating')
    end

    it 'orders posts based on their rating' do
      get api_posts_path
      json_response = JSON.parse(response.body)
      json_response[0...-1].each_with_index do |pst, i|
        this_posts_rating = pst['average_rating']
        next_posts_rating = json_response[i + 1]['average_rating']
        expect(this_posts_rating).to be >= next_posts_rating
      end
    end
  end
end
