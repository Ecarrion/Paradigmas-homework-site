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
      flash[:success] = "Welcome to the Paradigms Homeworks site. You could now start uploading your homeworks"
      redirect_to @user
    else
      @title = "Sign up"
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
