class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    load_recent_works
  end

  private

  def load_recent_works
    @works ||= work_scope.top_10_recent
  end

  def work_scope
    Work.all
  end
end
