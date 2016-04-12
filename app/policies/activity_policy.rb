class ActivityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:roadmap).where("roadmap.user_id = ?", user.id)
    end
  end

  def update?
    record.roadmap.user == user
  end

  def create?
    true
  end

  def destroy?
    record.roadmap.user == user
  end

  def up?
    update?
  end

  def down?
    update?
  end
end
