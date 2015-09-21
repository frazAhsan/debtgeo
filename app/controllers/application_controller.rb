class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_website


  def get_website
  	domain = request.host
  	#original_url = request.original_url
  	@site = Website.find_by(domain: domain)
  	#TODO below line should be removed later
  	@site = Website.first if @site.nil?

    I18n.locale = request.subdomain.blank? ? I18n.default_locale : request.subdomain
  end

  #def authenticate_admin_user!
  #  unless current_user.try(:admin?)
  #    redirect_to root_url, alert: "You dont have permission to access that area!"
  #  end
  #end
end
