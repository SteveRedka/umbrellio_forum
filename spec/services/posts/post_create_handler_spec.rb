require 'rails_helper'

RSpec.describe Posts::PostCreateHandler do
  valid_params = { header: 'foo',
                   content: 'bar',
                   ip: '127.0.0.1',
                   login: 'author' }

  context 'with valid params' do
    it 'creates a post' do
      expect do
        Posts::PostCreateHandler.new(valid_params).call
      end.to change { Post.count }.by(1)
    end

    context 'login' do
      it 'creates new user if there is no user with such login' do
        expect do
          Posts::PostCreateHandler.new(valid_params).call
        end.to change { User.count }.by(1)
      end

      it 'assigns existing author to new post' do
        author = create :user, login: 'author'
        expect do
          Posts::PostCreateHandler.new(valid_params).call
        end.to change { User.count }.by(0)
      end
    end

    context 'ip' do
      it 'creates new PosterIp if this ip doesn`t exist' do
        expect do
          Posts::PostCreateHandler.new(valid_params).call
        end.to change { PosterIp.count }.by(1)
      end

      context 'exists' do
        before do
          other_params = { header: 'other_header',
                           content: 'other_content',
                           ip: '127.0.0.1',
                           login: 'other_user' }
          Posts::PostCreateHandler.new(other_params).call
        end

        it 'records user id in existing PosterIp' do
          expect do
            Posts::PostCreateHandler.new(valid_params).call
          end.to change { PosterIp.count }.by(0)
        end

        it 'doesn`t write duplicate user ids in PosterIp'
      end
    end
  end

  context 'with invalid params' do
    it 'requires header to be at least 3 symbols long' do
      invalid_params = valid_params
      invalid_params[:header] = 'f'
      expect do
        Posts::PostCreateHandler.new(invalid_params).call
      end.to raise_error(ArgumentError)
    end

    it 'requires content to be at least 3 symbols long' do
      invalid_params = valid_params
      invalid_params[:content] = 'f'
      expect do
        Posts::PostCreateHandler.new(invalid_params).call
      end.to raise_error(ArgumentError)
    end
  end
end
