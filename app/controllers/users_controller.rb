# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    load_user
    load_works
    load_best
    load_recent
    load_all
  end

  def update
    load_user
    @user.update(clap_colour: params[:colour])
    redirect_to action: 'show'
  end

  private

  def load_user
    @user ||= user_scope.find(params[:id])
  end

  def load_works
    @works = @user.works
  end

  def load_all
    @all = @works.sort_by(&:updated_at).reverse!
  end

  def load_best
    @best = @works.all.max_by(&:day_clap_count)
  end

  def load_recent
    @recent = @works.all.max_by(&:updated_at)
  end

  def user_scope
    User.all
  end
end
