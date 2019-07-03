# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :is_signed_in?
  def index; end

  private

  def is_signed_in?
    redirect_to home_url if user_signed_in?
  end

end
