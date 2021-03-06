# == Schema Information
# Schema version: 20110216035731
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  epassword  :string(255)
#  salt       :string(255)
#  admin      :boolean
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :homeworks, :dependent => :destroy
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  
    
  validates :name, :presence => true,
                   :length => {:maximum => 50}
                   
  validates :email, :presence => true,
                    :uniqueness => {:case_sensitive => false},
                    :format => {:with => email_regex}
                    
    
  #Automatically create the virtual attribute 
  #'password_confirmation'.                  
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40}
                       
  before_save :encrypt_password
  
  
  def self.authenticate(submitted_email, submitted_pass)
    auth_user = User.find_by_email(submitted_email)
    return nil if auth_user.nil?
    return auth_user if auth_user.has_password?(submitted_pass)
  end
  
  def self.authenticate_with_salt(remembered_id, remembered_salt)
    remembered_user = User.find_by_id(remembered_id)
    return nil if remembered_user.nil?
    return remembered_user if remembered_user.salt = remembered_salt
  end
    
  def has_password?(submitted_pass)
    epassword == encrypt(submitted_pass)
  end
  
  
  private 
    def encrypt_password
      self.salt = make_salt if new_record?
      self.epassword = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
    
end
