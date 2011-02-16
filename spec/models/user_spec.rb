require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :name => "Example User", 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  it 'should create a user' do
    User.create!(@attr)
  end
  
  it 'should require a name' do
    u = User.new(@attr.merge(:name => ""))
    u.should_not be_valid    
  end
  
  it 'should reject long names' do
    long_name = 'a' * 51
    u = User.new(@attr.merge(:name => long_name))
    u.should_not be_valid
  end
  
  it 'should require an email' do
    u = User.new(@attr.merge(:email => ""))
    u.should_not be_valid
  end
  
  it 'should reject duplicated emails' do
    u = User.create!(@attr)
    u2 = User.new(@attr.merge(:name => "another name"))
    u2.should_not be_valid
  end
  
  it 'should reject email addresses identical up to case' do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user = User.new(@attr)
    user.should_not be_valid
  end
  
  it 'should accept a valid email' do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |addres|
      valid_email = User.new(@attr.merge(:email => addres))
      valid_email.should be_valid
    end
  end
  
  it 'should not accept a valid email' do
   addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |addres|
      invalid_email = User.new(@attr.merge(:email => addres))
      invalid_email.should_not be_valid
    end
  end
  
  
  it 'should require a pasword' do
    u = User.new(@attr.merge(:password => "", :password_confirmation => ""))
    u.should_not be_valid
  end
  
  it 'should require a password_confirmation' do
    u = User.new(@attr.merge(:password_confirmation => ""))
    u.should_not be_valid
  end
  
  it 'should reject a wrong password_confirmation' do
    u = User.new(@attr.merge(:password_confirmation => "foobar2"))
    u.should_not be_valid
  end
  
  it 'should reject long passwords' do
    long_pass = "a" * 41
    u = User.new(@attr.merge(:password => long_pass, :password_confirmation => long_pass))
    u.should_not be_valid
  end
end
