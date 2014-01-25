class Resume < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  
attr_accessible :name, :attachment, :level, :semester, :user_id ,:subject_id
 mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.
  validates :attachment, presence: true
  validates :semester, presence: true
  validates :subject_id, presence: true
  validates :level, presence: true
  
  validates_format_of :name, :with => /\A^[^`!@#\$%\^&*+=]+$\Z/  , length: { maximum: 100 }
			 
end

