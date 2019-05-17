class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    load_works
  end

  private

  def load_works
    @works ||= work_scope.to_a
  end

  def work_scope
    Work.all.where(user_id: current_user.id)
  end
end
