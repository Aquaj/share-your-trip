class Users::RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :status, :luggage, :local_mobility, :travel_type, :accomodation_type, :avatar)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :status, :luggage, :local_mobility, :travel_type, :accomodation_type, :avatar)
  end
end
