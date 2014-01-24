class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :title, :user
  default_scope -> { order('created_at DESC') }
  validates :body,presence: true
  validates :title, presence: true
end
