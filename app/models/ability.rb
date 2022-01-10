# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Hall
    can :manage, Order, confirmed: false
    can :read, Order
    cannot :manage, Order, %i[confirmed added_by]
    can :manage, Task

    return unless user.admin?

    can :manage, Order
    can :manage, User
  end
end
