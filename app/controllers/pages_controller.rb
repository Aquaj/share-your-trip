class PagesController < ApplicationController
  def home
    authorize :home, :home?
  end
end
