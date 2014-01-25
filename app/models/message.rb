class Message < ActiveRecord::Base
  belongs_to :user
  has_many :responses, dependent: :destroy
  
  attr_accessible :message_content , :user_id , :receiver_id
  validates :message_content, :presence => true
  validates :receiver_id, :presence => true
end
