class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Share your Trip')
  end

  def itinerary(user, roadmap)
    @user = user
    @roadmap = roadmap

    mail(to: @user.email, subject: 'Your itinerary')
  end

  def contact(sender, subject, body)
    @date = DateTime.new
    @sender = sender
    @body = body
    mail(to: "jupierrat@gmail.com", subject: "Contact Client - #{subject}")
  end
end

