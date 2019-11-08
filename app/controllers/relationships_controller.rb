class RelationshipsController < ApplicationController
  before_action :load_user_destroy, only: :destroy
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js{flash.now[:danger] = t ".error_user_ajax"}
      end
    end
  end

  def destroy
    if @user
      current_user.unfollow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js{flash.now[:danger] = t ".error_user_ajax"}
      end
    end
  end

  private

  def load_user_destroy
    @relationship = Relationship.find_by id: params[:id]
    if @relationship
      @user = @relationship.followed
    else
      flash[:warning] = t ".not_found"
      redirect_to root_path
    end
  end
end
