require 'rails_helper'

RSpec.describe 'Api::V1::Ratings', type: :request do
  describe 'POST /api/rate(:id)' do
    let!(:rateable) { create :post }

    it 'creates a rating' do
      expect do
        post(api_rate_path(rateable.id),
             params: { value: 3 })
      end.to change { Rating.count }.by(1)
      expect(response).to have_http_status(200)
    end

    context 'with invalid data' do
      it 'returns unprocessable entry code with validation errors' do
        expect do
          post(api_rate_path(rateable.id))
        end.to change { Rating.count }.by(0)
        expect(response.body).to include('error')
        expect(response.body).to include('value')
        expect(response).to have_http_status(422)
      end
    end
  end
end
