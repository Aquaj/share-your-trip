class PagesPolicy < ApplicationPolicy
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
