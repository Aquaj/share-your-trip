class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user  # Instance variable => available in view
    mail(to: @user.email, subject: 'Welcome to Share your Trip')
    # This will render a view in `app/views/user_mailer`!
  end

  def itinerary(user, roadmap)
    @user = user
    @roadmap = roadmap

    mail(to: @user.email, subject: 'Your itinerary')
  end


end

