class SessionsController < ApplicationController
  
  
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    
    if user
      sign_in user
      redirect_to user
    elsif
      flash.now[:error] = "Invalid Email/Password combination."
      @title = "Sign in"
      render :new
    end
  end

end
