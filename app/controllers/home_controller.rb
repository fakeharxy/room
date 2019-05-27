class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    load_active if params[:type] == "active" || params[:type] == nil
    load_popular_works if params[:type] == "popular"
    load_bookmarks if params[:type] == "bookmark"
  end

  private

  def load_recent_works
    @recent_works ||= work_scope.top_10_recent
  end

  def load_active
    @active ||= Work.active
  end

  def load_popular_works
    @popular ||= Work.popular
  end

  def load_bookmarks
    @bookmarked_works ||= current_user.bookmarked_works
  end

  def work_scope
    Work.all
  end
end
