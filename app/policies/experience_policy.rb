class ExperiencePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.includes(:photo_files, :category).all
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

  def my_experiences?
    true
  end

  def send_experience?
    true
  end
end
