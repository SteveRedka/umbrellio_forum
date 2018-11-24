require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'get /api/users/list_trolls' do
    let!(:legit_ip) { create :poster_ip, ip: '127.0.0.1' }
    let!(:troll_ip) { create :poster_ip, ip: '8.8.8.8' }
    let!(:user1) { create :user }
    let!(:troll1) { create :user }
    let!(:troll2) { create :user }

    before do
      legit_ip.users << user1
      troll_ip.users << troll1
      troll_ip.users << troll2
      get(api_users_list_trolls_path)
    end

    it 'doesn`t return ips that had only one user posting from them' do
      expect(response.body).not_to include(legit_ip.ip)
    end

    it 'returns ips that had multiple users posting from them' do
      expect(response.body).to include(troll_ip.ip)
    end

    it 'returns lists of users who posted from those ips' do
      expect(response.body).to include(troll1.login)
      expect(response.body).to include(troll2.login)
    end
  end
end
