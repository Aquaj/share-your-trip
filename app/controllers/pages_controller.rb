class PagesController < ApplicationController
  skip_before_action :authenticate_user_for_beta!

  def landing_page
    authorize :pages, :landing_page?
    redirect_to experiences_path if user_signed_in?
  end

  def save_email
    authorize :pages, :save_email?
    # TODO: stock mail
    # TODO: open to specific emails
    redirect_to new_user_session_path if params[:email] == "aquajvalin@gmail.com"
  end

  def home
    authorize :pages, :home?
    @experiences = policy_scope(Experience).sort{ |e, f| f.average_rating - e.average_rating }[0..2]
    if user_signed_in?
      redirect_to experiences_path
    end
  end

  def contact
    authorize :pages, :contact?
  end

  def contact_mail
    authorize :pages, :contact_mail?
    params.require(:contact).permit(:contact_address, :subject, :body)
    if UserMailer.contact(params[:contact][:contact_address], params[:contact][:subject], params[:contact][:body]).deliver_now
      flash[:notice] = "Votre message a bien été envoyé."
      redirect_to contact_path
    else
      flash[:alert] = "Une erreur s'est produite."
      redirect_to contact_path
    end
  end

  def cgu
    authorize :pages, :cgu?
  end
end
