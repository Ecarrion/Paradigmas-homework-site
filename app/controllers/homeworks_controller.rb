class HomeworksController < ApplicationController
  
  before_filter :authenticate, :only => [:new, :create]
  
  def new
    @title = "Add Homework"
    @homework = Homework.new
  end
  
  def create
    @homework = current_user.homeworks.build(params[:homework])
    if @homework.save
      flash[:success] = "Homework succesfully uploaded"
      redirect_to current_user
    elsif
      @title = "Add Homework"
      render :new
    end
  end

  def show
    @homework = Homework.find_by_id(params[:id])
    @title = @homework.name
  end
  
  
  private
    def authenticate
        deny_access unless signed_in?
    end

end
