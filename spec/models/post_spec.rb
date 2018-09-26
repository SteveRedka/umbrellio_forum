require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'should belong to user'
  context 'header' do
    it 'should not be blank'
  end
  context 'ip' do
    it 'should not be blank'
  end
end
