class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    authorize :home, :home?
    @experiences = policy_scope(Experience).sample(3)
  end
end
