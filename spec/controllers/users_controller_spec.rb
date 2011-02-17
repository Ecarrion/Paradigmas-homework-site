require 'spec_helper'

describe UsersController do
  
  render_views

  describe "GET 'index'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful if signed in" do
      test_sign_in @user
      get :index
      response.should be_success
    end
    
    it "should not be successful if not signed in" do
      get :index
      response.should_not be_success
    end
    
    it 'should have the right title' do
      test_sign_in @user
      get :index
      response.should have_selector("title", :content => "All users")
    end
    
    it 'should dispay the users' do
      second = Factory(:user, :email => "another@example.com")
      third  = Factory(:user, :email => "another@example.net")

      @users = [@user, second, third]
      
      30.times do
        @users << Factory(:user, :email => Factory.next(:email))
      end
      
      test_sign_in @user
      get :index
      @users[0..2].each do |user|
        response.should have_selector("li", :content => user.name)
      end
      
    end    
  end

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
   it "should be successful" do
      get :show, :id => @user
      response.should be_success
   end
   
   it 'should have the right title' do
     get :show, :id => @user
     response.should have_selector("title", :content => @user.name)
   end
   
   it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end   
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
    
    it "should have a name field" do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end

    it "should have an email field" do
      get :new 
      response.should have_selector("input[name='user[email]'][type='text']")
    end

    it "should have a password field" do
      get :new
      response.should have_selector("input[name='user[password]'][type='password']")
    end

    it "should have a password confirmation field" do
      get :new
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
  end

  describe "POST 'create'" do
    
    describe 'failure' do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end
      
      it 'should not create a user' do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it 'should have the signup title' do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end
      
      it 'should redirect to the "new" page' do
        post :create, :user => @attr
        response.should render_template(:new)
      end
      
      it 'should render error messages' do
        post :create, :user => @attr
        response.should have_selector("div#error_explanation")        
      end
      
      it 'should clear the password field' do
        post :create, :user => @attr.merge(:password => "invalid")
        assigns(:user).password.should be_blank
      end
      
      it 'should clear the password_confirmation field' do
        post :create, :user => @attr.merge(:password_confirmation => "invalid2")
        assigns(:user).password_confirmation.should be_blank
      end
      
    end
    
    describe 'success' do
       
      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end
      
      it 'should create a user' do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it 'should redirect to the users show page' do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it 'should have a wellcome flash message' do
        post :create, :user => @attr
        flash[:success].should =~ /Welcome to the Paradigms Homeworks site. You can start uploading your homeworks now!/i
      end
      
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      #pending
#      get :edit
#      response.should be_success
    end
  end

  describe "PUT 'update'" do

  end

  describe "DELETE 'destroy'" do

  end

end
