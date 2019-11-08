class Users::FollowsController < UsersController
  def following
    @title = t ".following"
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.per_page
    render :show_follow
  end

  def followers
    @title = t ".followers"
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.per_page
    render :show_follow
  end
end
