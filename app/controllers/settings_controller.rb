# frozen_string_literal: true

class SettingsController < ApplicationController
  def show; end

  def update
    load_user
  end

  private

  def load_user
    @user = User.find_by_id(params[:id])
  end
end
