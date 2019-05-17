# frozen_string_literal: true

class Work < ApplicationRecord
  validates :title, :genre, presence: true

  belongs_to :user
end
