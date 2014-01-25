class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :subject
  belongs_to :user
  
  attr_accessible :question_content, :subject_id , :user_id
  
  validates :question_content , presence: true
end
