class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    authorize :home, :home?
    @experiences = policy_scope(Experience).sort{ |e| e.average_rating }[0..2]
    if user_signed_in?
      redirect_to experiences_path
    end
  end
end
