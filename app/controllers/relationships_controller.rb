class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user_followed, only: :create
  before_action :load_relationship, only: :destroy
  after_action :respond_to_data

  def create
    current_user.follow @user
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow @user
  end

  private

  def respond_to_data
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def load_user_followed
    @user = User.find_by id: params[:followed_id]
    return if @user
    flash[:warning] = t "static_pages.login.load_user_danger"
    redirect_to root_path
  end

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
    return if @relationship
    flash[:warning] = t "static_pages.login.load_user_danger"
    redirect_to root_path
  end
end
