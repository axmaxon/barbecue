class ApplicationPolicy
  attr_reader :user, :record, :pundit_user, :cookies

  delegate :user, to: :pundit_user
  delegate :cookies, to: :pundit_user

  def initialize(pundit_user, record)
    @pundit_user = pundit_user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
