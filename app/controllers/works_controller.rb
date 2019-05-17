# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :authenticate_user!

  def index
    load_works
  end

  def new
    build_work
  end

  def create
    build_work
    save_work || render('new')
  end

  def show
    load_work
  end

  private

  def load_works
    @works ||= work_scope.where(user_id: current_user.id).to_a
  end

  def load_work
    @work ||= work_scope.find(params[:id])
  end

  def build_work
    @work ||= work_scope.build
    @work.attributes = work_params
    @work.user = current_user
  end

  def save_work
    redirect_to @work if @work.save
  end

  def work_params
    work_params = params[:work]
    work_params ? work_params.permit(:title, :genre) : {}
  end

  def work_scope
    Work.all
  end
end
