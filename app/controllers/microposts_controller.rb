class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      do_save_success
    else
      do_save_fail
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".micropost_deleted"
    else
      flash[:danger] = t ".micropost_delete_fail"
    end
    redirect_to request.referer || root_path
  end

  private

  def do_save_success
    flash[:success] = t ".micropost_created"
    redirect_to root_path
  end

  def do_save_fail
    @feed_items = current_user.microposts.order_desc .paginate page:
        params[:page], per_page: Settings.per_page
    render "static_pages/home"
  end

  def micropost_params
    params.require(:micropost).permit Micropost::DATA_TYPE
  end

  def correct_user
    @micropost = current_user.microposts.order_desc.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t ".not_allow"
    redirect_to root_path
  end
end
