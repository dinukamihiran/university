class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :replies, dependent: :destroy
  
  attr_accessible :answer_content , :question_id , :user_id
  validates :answer_content , presence: true
end
