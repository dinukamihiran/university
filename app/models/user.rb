class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :messages, dependent: :destroy
  has_many :statuses, dependent: :destroy
  
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followed_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, through: :follower_relationships
  has_many :followeds, through: :followed_relationships
  
		    attr_accessible :email, :password, :password_confirmation, :full_name, :batch, :degree , :username

		    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }		  
			validates :username, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
			 
			 validates_format_of :full_name, :with => /\A^[^0-9`!@#\$%\^&*+_=]+$\Z/  , length: { maximum: 100 }
			 validates_format_of :degree, :with => /\A^[^0-9`!@#\$%\^&*+_=]+$\Z/ , length: { maximum: 50 }
			 validates_format_of :username, :with => /\A^[^`!@#\$%\^&*+_=]+$\Z/ , length: { maximum: 20 }
			 validates :batch, :numericality => true , length: { maximum: 2 }
			 
			 validates :full_name, :presence => true
			 validates :degree, :presence => true 
			 validates :batch, :presence => true
			 
def following? user
    self.followeds.include? user
end
 
def follow user
    Relationship.create follower_id: self.id, followed_id: user.id
end

end
