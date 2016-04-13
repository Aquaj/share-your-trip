class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    flash.delete(:notice)
  end

  def delete
    super
    flash.delete(:notice)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :accepted, :status, :luggage, :local_mobility, :travel_type, :accomodation_type, :avatar)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :status, :luggage, :local_mobility, :travel_type, :accomodation_type, :avatar)
  end
end
