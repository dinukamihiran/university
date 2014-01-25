class Reply < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user
  
  attr_accessible :reply_content , :answer_id , :user_id
end
