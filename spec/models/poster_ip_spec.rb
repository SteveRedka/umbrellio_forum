require 'rails_helper'

RSpec.describe PosterIp, type: :model do
  let!(:user1) { create :user }
  let!(:user2) { create :user }

  it 'is created with posts' do
    expect { create :post, user: user1 }.to change { PosterIp.count }.by(1)
  end

  it 'includes new user_id upon post creation' do
    create :post, user: user1, ip: '8.8.8.8'
    create :post, user: user2, ip: '8.8.8.8'
    poster_ip = PosterIp.last
    expect(poster_ip.ip).to eq('8.8.8.8')
    expect(poster_ip.user_ids).to include(user1.id.to_s)
    expect(poster_ip.user_ids).to include(user2.id.to_s)
  end

  it 'doesn`t include duplicate user_ids if it is already added' do
    create :post, user: user1, ip: '8.8.8.8'
    create :post, user: user1, ip: '8.8.8.8'
    create :post, user: user1, ip: '8.8.8.8'
    poster_ip = PosterIp.last
    expect(poster_ip.user_ids.length).to eq 1
  end
end
