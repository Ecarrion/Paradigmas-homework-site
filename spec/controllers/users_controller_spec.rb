require 'spec_helper'

describe UsersController do
  
  render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it 'should have the right title' do
      get :index
      response.should have_selector("title", :content => "All users")
    end    
  end

  describe "GET 'show'" do
   it "should be successful" do
     pending
#      get :show
#      response.should be_success
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

  end

  describe "GET 'edit'" do
    it "should be successful" do
      pending
#      get :edit
#      response.should be_success
    end
  end

  describe "PUT 'update'" do

  end

  describe "DELETE 'destroy'" do

  end

end
