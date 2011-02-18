class HomeworksController < ApplicationController
  
  before_filter :authenticate, :only => [:new, :create, :destroy]
  before_filter :correct_user, :only => [:destroy] 
  
  def new
    @title = "Add Homework"
    @homework = Homework.new
  end
  
  def create
    @homework = current_user.homeworks.build(params[:homework])
    if @homework.save
      flash[:success] = "Homework succesfully uploaded"
      redirect_to current_user
    else
      @title = "Add Homework"
      render :new
    end
  end

  def show
    @homework = Homework.find(params[:id])
    @title = @homework.name
  end
  
  def destroy
    Homework.find(params[:id]).destroy
    flash[:success] = "Homework succesfully deleted."
    redirect_to current_user
  end
  
  
  private
    def authenticate
        deny_access unless signed_in?
    end
    
    def correct_user
      @user = Homework.find(params[:id]).user
      redirect_to(root_path) unless current_user?(@user)
    end

end
