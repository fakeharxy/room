# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    load_active if params[:type] == 'active' || params[:type].nil?
    load_popular_works if params[:type] == 'popular'
    load_bookmarks if params[:type] == 'bookmark'
    load_genre_search if params[:type] == 'search'
    load_following if params[:type] == 'following'
    load_user_search if params[:type] == 'user'
  end

  private

  def load_active
    @active ||= Work.active
  end

  def load_popular_works
    @popular ||= Work.popular
  end

  def load_bookmarks
    @bookmarked_works ||= current_user.bookmarked_works
  end

  def load_following
    @following ||= current_user.following_works
  end

  def load_genre_search
    if params[:criteria] && params[:criteria] != ''
      @genre_search = params[:criteria]
      @results = Work.genre_results(params[:criteria])
    end
    @genre_search ||= 'Search'
  end

  def load_user_search
    if params[:criteria] && params[:criteria] != ''
      @user_search = params[:criteria]
      @users = User.user_results(params[:criteria])
    end
    @user_search ||= 'Search'
  end

  def work_scope
    Work.all
  end
end
