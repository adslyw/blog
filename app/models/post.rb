class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :title, :user

  validates :body,presence: true
  validates :title, presence: true
end
