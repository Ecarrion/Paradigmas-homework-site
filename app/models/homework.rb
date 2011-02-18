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
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :path => ":attachment/:#{:id}-:#{:filename}"
  
end
