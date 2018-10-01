require 'rails_helper'

RSpec.describe 'Api::V1::Ratings', type: :request do
  describe 'POST /api/rate(:id)' do
    let!(:rateable) { create :post }

    it 'creates a rating' do
      expect do
        post(api_rate_path(rateable.id),
             params: { post_id: rateable.id, value: 3 })
      end.to change { Rating.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end
end
