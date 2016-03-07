class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    authorize :home, :home?
    @experiences = policy_scope(Experience).sample(3)
    if user_signed_in?
      @experience = current_user.experiences.new
    end
  end
end
