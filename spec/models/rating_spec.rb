require 'rails_helper'

RSpec.describe Rating, type: :model do
  let!(:rating) { create :rating }

  it 'should belong to user' do
    rating.user = nil
    expect(rating).not_to be_valid
  end

  it 'should belong to post' do
    rating.post = nil
    expect(rating).not_to be_valid
  end
end
