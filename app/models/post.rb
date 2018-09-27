class Post < ApplicationRecord
  belongs_to :user
  validates_presence_of :header, :content, :length => {:minimum => 3 }
end
