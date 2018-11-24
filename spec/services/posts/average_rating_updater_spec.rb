require 'rails_helper'

RSpec.describe Posts::AverageRatingUpdater do
  let!(:post) { create :post }
  before do
    post.ratings.create(value: 3)
    post.ratings.create(value: 4)
  end

  it 'works' do
    expect(Posts::AverageRatingUpdater.new(post).call).to eq 3.5
  end
end
