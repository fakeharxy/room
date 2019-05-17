# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorksController, type: :controller do
  include Devise::Test::ControllerHelpers
  describe 'GET #index' do
    it 'returns http found' do
      get :index
      expect(response).to have_http_status(:found)
    end
  end
end
