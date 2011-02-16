class UsersController < ApplicationController
  def index
    @title = "All users"
  end

  def show
    @title = ""
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    
  end

  def edit
    @title = "Edit user"
  end

  def update
  end

  def destroy
  end

end
