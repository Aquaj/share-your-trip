class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Share your Trip')
  end

  def itinerary(user, roadmap)
    @user = user
    @roadmap = roadmap

    mail(to: @user.email, subject: 'Votre itinéraire')
  end

  def contact(sender, subject, body)
    @date = DateTime.new
    @sender = sender
    @body = body
    mail(to: "jupierrat@gmail.com", subject: "Contact Client - #{subject}")
  end

  def experience(to, url)
    @url = url
    mail(to: to, subject: "Quelqu'un souhaite partager un coup de coeur avec vous.")
  end
end

