require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'POST /api/v1/posts' do
    let!(:user) { create :user, login: 'author' }
    valid_post = { header: 'header', content: 'foo' }
    valid_user = { login: 'author' }

    context 'with valid post inputs' do
      context 'with valid user' do
        it 'creates post, but not user' do
          expect do
            post(api_posts_path, params: { post: valid_post,
                                           user: valid_user })
          end.to change { Post.count }.by(1).and change { User.count }.by(0)
          expect(response).to have_http_status(200)
        end
      end

      context 'with missing user' do
        it 'doesn`t create posts nor users' do
          expect do
            post(api_posts_path, params: { post: valid_post })
          end.to change { Post.count }.by(0).and change { User.count }.by(0)
          expect(response).to have_http_status(400)
        end
      end
    end

    context 'with missing post fields' do
      it 'should not create user' do
        # parameters = { user: valid_user }
        expect do
          post(api_posts_path, params: { user: valid_user })
        end.to change { Post.count }.by(0)
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /api/v1/posts' do
    it 'works! (now write some real specs)' do
      get api_posts_path
      expect(response).to have_http_status(200)
    end
  end
end
