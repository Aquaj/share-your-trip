class RoadmapPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where("user_id = ?", user.id)
    end
  end

  def index
    true
  end

  def show
    record.user == user
  end

  def update?
    record.user == user
  end

  def edit?
    update?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def destroy?
    record.user == user
  end
end
