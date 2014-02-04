class Micropost < ActiveRecord::Base
  validates :user_id, presence:true
  default_scope -> {order('created_at DESC')}
  validates(:content, length: {maximum: 140}, presence: true)
  belongs_to :user
end
