class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:user][:username])

    if @user.nil?
      @user = User.new(username: params[:user][:username], joined: Date.today)
      if !@user.save
        render :login_form
      else
        flash[:welcome] = "Welcome #{@user.username}"
        redirect_to root_path
      end
    else
      flash[:welcome] = "Welcome back #{@user.username}"
      redirect_to root_path
    end

    session[:user_id] = @user.id
  end

  def logout
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      unless @user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye #{@user.username}"
      else
        session[:user_id] = nil
        flash[:notice] = "Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
    end
  end
end
