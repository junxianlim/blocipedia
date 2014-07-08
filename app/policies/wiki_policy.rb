class WikiPolicy < ApplicationPolicy

  def index?
    wikipolicy_params
  end

  def show?
    record.public? || wikipolicy_params
  end

  def create?
    wikipolicy_params
  end

  def update?
    create?
  end

  def destroy?
    wikipolicy_params
  end

  def wikipolicy_params
    (user.present? && (record.user == user || user.role?(:admin)))
  end
end