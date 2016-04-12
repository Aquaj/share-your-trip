class PagesPolicy < ApplicationPolicy
  def landing_page?
    true
  end

  def save_email?
    true
  end

  def home?
    true
  end

  def contact?
    true
  end

  def contact_mail?
    true
  end

  def cgu?
    true
  end
end
