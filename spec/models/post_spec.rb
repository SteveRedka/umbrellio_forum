require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post) { create :post }

  it 'belongs to user' do
    expect(post.user).not_to be_blank
  end

  context 'ratings' do
    before do
      create :rating, post: post, value: 4
      create :rating, post: post, value: 5
    end

    it 'has many ratings' do
      expect(post.ratings.count).to eq(2)
    end

    it 'returns average rating' do
      expect(post.average_rating).to eq(4.5)
    end
  end
end
