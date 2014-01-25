class Subject < ActiveRecord::Base
 has_many :questions , dependent: :destroy
 has_many :resumes 
 attr_accessible :name , :id , :subject_code
 
end
