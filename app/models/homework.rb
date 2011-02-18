# == Schema Information
# Schema version: 20110217233611
#
# Table name: homeworks
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  file       :string(255)
#  created_at :datetime
#  updated_at :datetime
#



class Homework < ActiveRecord::Base
  
  attr_accessible :name, :file
  
  validates :name, :presence => true,
                   :length => {:maximum => 60}
                   
#  validates :file, :presence => true
#                   :length => {:maximum => 255}
  
  belongs_to :user
  
  default_scope :order => 'homeworks.created_at DESC'
  
  #paperclip
  has_attached_file :file,
      :storage => :s3,
      :s3_credentials => {:access_key_id => ENV['S3_KEY'],
                          :secret_access_key => ENV['S3_SECRET'],
                          :bucket => ENV['S3_BUCKET']},
      :path => ":attachment/:#{:id}-:#{:filename}"
  
end
