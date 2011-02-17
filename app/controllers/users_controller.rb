class UsersController < ApplicationController
  def index
    @title = "All users"
  end

  def show
    @user = User.find_by_id(params[:id])
    @title = @user.name
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      sign_in @user
      message = "Welcome to the Paradigms Homeworks site. You can start uploading your homeworks now!"
      flash[:success] = message
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
      render :new
    end
    
  end

  def edit
    @title = "Edit user"
  end

  def update
  end

  def destroy
  end

end
