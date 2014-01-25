class Status < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :status_content, :user_id
  
             validates :status_content, :presence => true
			 validates :user_id, :presence => true 
end
