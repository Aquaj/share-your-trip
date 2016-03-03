class WishlistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where("user_id = ?", user.id)
    end
  end

  def index
    true
  end

  def create?
    !scope.where("user_id = ? AND experience_id = ?", user.id, record.experience_id).exists?
  end

  def destroy?
    record.user == user
  end
end
