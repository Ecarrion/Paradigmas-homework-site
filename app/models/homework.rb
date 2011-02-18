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
  
  validates :name, :presence => true,
                   :length => {:maximum => 200}
                   
  validates :file, :presence => true,
                   :length => {:maximum => 255}
  
  belongs_to :user
  
end
