class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user_for_beta, unless: :devise_controller?
  before_action :authenticate_user!

  include Pundit

  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "Vous n'avez pas les autorisations nécessaires pour effectuer cette action."
    redirect_to(root_path)
  end

  def authenticate_user_for_beta
    if !user_signed_in?
      redirect_to(root_path)
    else
      authenticate_user! # Shouldn't have to get there.
    end
  end
end
