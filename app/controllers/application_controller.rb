class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception
  include SessionsHelper

  def not_found
    render file: Rails.root.join("public", "404.html"),
      status: :not_found, layout: false
    logger.info "Rendering 404"
  end

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".please_log_in"
    redirect_to login_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
