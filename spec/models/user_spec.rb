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
  
  
  describe 'password encryption' do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it 'should have an encrypted password' do
      @user.should respond_to(:epassword)
    end
    
    it 'should assign the encrypted password' do
      @user.epassword.should_not be_blank   
    end
    
    
    describe 'has_password? method' do
      
      it 'should be true if the passwords match' do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it 'should be false if the passwords doesnt match' do
        @user.has_password?("error").should be_false
      end
      
    end
    
     describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
    
  end
end
