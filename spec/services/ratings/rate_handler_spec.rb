require 'rails_helper'

RSpec.describe Ratings::RateHandler do
  let!(:rateable) { create :post }

  it 'returns average rating of a post' do
    expect(Ratings::RateHandler.new(post_id: rateable.id,
                                    value: 5).call).to eq(5.0)
    expect(Ratings::RateHandler.new(post_id: rateable.id,
                                    value: 4).call).to eq(4.5)
  end

  it 'handles concurrent requests properly'

  context 'invalid requests' do
    it 'raises an error if post doesn`t exist' do
      expect do
        Ratings::RateHandler.new(post_id: 9999,
                                      value: 5).call
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'raises an error if value is inapropriate' do
      expect do
        Ratings::RateHandler.new(post_id: rateable.id,
                                      value: 99).call
      end.to raise_error(ArgumentError)
      expect do
        Ratings::RateHandler.new(post_id: rateable.id,
                                      value: -5).call
      end.to raise_error(ArgumentError)
    end
  end
end

