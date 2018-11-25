require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'POST /api/posts' do
    valid_request = { header: 'foo', content: 'bar',
                      login: 'author', ip: '0.0.0.0' }

    let!(:user) { create :user, login: valid_request[:login] }

    it 'creates posts' do
      expect do
        post(api_posts_path, params: valid_request)
      end.to change { Post.count }.by(1)
      expect(response).to have_http_status(200)
      expect(response.body).to include(valid_request[:header])
      expect(response.body).to include(valid_request[:content])
      expect(Post.last.user).to eq(user)
    end

    context 'with invalid data' do
      it 'returns unprocessable entry code with validation errors' do
        expect do
          post(api_posts_path, params: { login: 'author' })
        end.to change { Post.count }.by(0)
        expect(response.body).to include('error')
        expect(response.body).to include('header')
        expect(response.body).to include('content')
        expect(response).to have_http_status(422)
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

    it 'orders posts based on their rating' do
      get api_posts_path
      json_response = JSON.parse(response.body)
      json_response[0...-1].each_with_index do |pst, i|
        this_posts_rating = Post.find(pst['id']).average_rating
        next_posts_rating = Post.find(json_response[i + 1]['id']).average_rating
        expect(this_posts_rating).to be >= next_posts_rating
      end
    end
  end
end
