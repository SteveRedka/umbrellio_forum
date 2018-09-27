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

  describe 'GET /api/posts' do
    it 'lists top 10 posts based on average rating'
  end
end
