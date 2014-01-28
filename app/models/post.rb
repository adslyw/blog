# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  attr_accessible :body, :title, :user
  default_scope -> { order('created_at DESC') }
  validates :body,presence: true
  validates :title, presence: true
end
