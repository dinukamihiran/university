class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  
  attr_accessible :user_id , :response_content , :message_id  
end
