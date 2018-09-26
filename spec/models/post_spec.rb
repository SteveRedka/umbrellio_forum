require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post) { create :post }

  it 'should belong to user' do
    expect(post.user).not_to be_blank
  end
end
