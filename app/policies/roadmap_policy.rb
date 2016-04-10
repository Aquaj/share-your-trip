class RoadmapPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index
    true
  end

  def show
    true
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
