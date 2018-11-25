require 'rails_helper'

RSpec.describe Users::TrollSearcher do
  let!(:legit_ip) { create :poster_ip, ip: '127.0.0.1' }
  let!(:troll_ip) { create :poster_ip, ip: '8.8.8.8' }
  let!(:user1) { create :user }
  let!(:troll1) { create :user }
  let!(:troll2) { create :user }

  before do
    legit_ip.users << user1
    troll_ip.users << troll1
    troll_ip.users << troll2
  end

  it 'doesn`t return ips that had only one user posting from them' do
    expect(Users::TrollSearcher.new.call[legit_ip.ip]).to be_nil
  end

  it 'returns ips that had multiple users posting from them' do
    expect(Users::TrollSearcher.new.call[troll_ip.ip]).not_to be_nil
  end

  it 'returns lists of users who posted from those ips' do
    expect(Users::TrollSearcher.new.call[troll_ip.ip]).to include(troll1.login)
    expect(Users::TrollSearcher.new.call[troll_ip.ip]).to include(troll2.login)
  end
end
