# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :authenticate_user!

  def index
    load_works
  end

  def new
    @work ||= work_scope.build
    @work.user = current_user
  end

  def create
    build_work
    set_up_twitter
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
    @work.update(show_prompt: false) if work_params['show_prompt'] != 'on'
    @work.user = current_user
  end

  def set_up_twitter
    require 'twitter'

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  def save_work
    if @work.save
      if ENV['ENVIRONMENT'] == 'production'
        @client.update("#{@work.user.username} just started a new piece of writing called #{@work.title} on app.writeroom.online! Why not check it out? #writeroom #writing #amwriting")
      end
      redirect_to @work
    end
  end

  def work_params
    work_params = params[:work]
    work_params ? work_params.permit(:title, :genre, :prompt, :show_prompt) : {}
  end

  def work_scope
    Work.all
  end
end
