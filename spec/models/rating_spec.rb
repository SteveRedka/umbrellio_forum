require 'rails_helper'

RSpec.describe Rating, type: :model do
  context 'value' do
    it 'should not be less than 1'
    it 'should not be more than 5'
    it 'should not be blank'
  end
  it 'should always belong to post'
end
