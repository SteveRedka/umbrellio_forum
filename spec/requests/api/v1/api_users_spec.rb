require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'get /api/users/list_trolls' do
    legit_ip = '127.0.0.1'
    troll_ip = '8.8.8.8'
    let!(:user1) { create :user }
    let!(:user2) { create :user }

    before do
      create :post, user: user1, ip: legit_ip
      create :post, user: user1, ip: troll_ip
      create :post, user: user2, ip: troll_ip
      get(api_users_list_trolls_path)
    end

    it 'doesn`t return ips that had only one user posting from them' do
      expect(response.body).not_to include(legit_ip)
    end

    it 'returns ips that had multiple users posting from them' do
      expect(response.body).to include(troll_ip)
    end

    it 'returns lists of users who posted from those ips' do
      expect(response.body).to include(user1.login)
      expect(response.body).to include(user2.login)
    end
  end
end
