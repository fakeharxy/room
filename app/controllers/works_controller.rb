# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :authenticate_user!

  def index
    load_works
    Work.each do |work|
      work.update(prompt: '')
    end
  end

  def new
    @work ||= work_scope.build
    @work.user = current_user
  end

  def create
    build_work
    save_work || render('new')
  end

  def show
    load_work
  end

  def unbookmark
    current_user.remove_bookmarked_work(params[:id])
  end

  private

  def load_works
    @works ||= work_scope.where(user_id: current_user.id).sort_by(&:updated_at).reverse!
  end

  def load_work
    @work ||= work_scope.find(params[:id])
  end

  def build_work
    @work ||= work_scope.build
    @work.attributes = work_params
    if work_params['show_prompt'] != 'on'
      @work.update(show_prompt: false)
    end
    @work.user = current_user
  end

  def save_work
    redirect_to @work if @work.save
  end

  def work_params
    work_params = params[:work]
    work_params ? work_params.permit(:title, :genre, :prompt, :show_prompt) : {}
  end

  def work_scope
    Work.all
  end
end
