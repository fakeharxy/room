class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    load_active
    load_recent_works
    load_bookmarks
  end

  private

  def load_recent_works
    @recent_works ||= work_scope.top_10_recent
  end

  def load_active
    @active ||= Work.active
  end

  def load_bookmarks
    @bookmarked_works ||= current_user.bookmarked_works
  end

  def work_scope
    Work.all
  end
end
