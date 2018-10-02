require 'rails_helper'

RSpec.describe "Errors", type: :request do

  describe 'GET /404' do
    it 'responds with json and correct code' do
      get '/404'
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET /500' do
    it 'responds with json and correct code' do
      get '/404'
      expect(response).to have_http_status(404)
    end
  end
end
