# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, :all if user.role == "admin"

    if user.role == "author"
      can :create, Article
      can [:create, :read], Comment
      can [:update, :destroy], Comment, user_id: user.id
      can [:update, :destroy, :read], Article, user_id: user.id
    end
  end
end
