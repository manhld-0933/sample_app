class SessionsController < ApplicationController
  before_action :load_user, only: :create
  before_action :check_logged_in, only: :new

  def new; end

  def create
    return check_rmb_me @user if @user.authenticate params[:session][:password]
    flash.now[:danger] = t "static_pages.login.danger"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def check_rmb_me user
    log_in user
    if params[:session][:remember_me] == Settings.remember_me
      remember user
    else
      forget user
    end
    redirect_to user
  end

  def load_user
    @user = User.find_by(email: params[:session][:email].downcase)
    return if @user
    flash[:warning] = t "static_pages.login.load_user_danger"
    redirect_to root_path
  end

  def check_logged_in
    redirect_to root_path if logged_in?
  end
end
