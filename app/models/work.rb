# frozen_string_literal: true

class Work < ApplicationRecord
  validates :title, :genre, presence: { message: "must be filled in!" }
  validates :title, :genre, length: { maximum: 20 }
  belongs_to :user
  has_many :bookmarks


  def self.top_10_recent
    Work.order('updated_at DESC').limit(10)
  end

  def self.active
    Work.where("updated_at > ?", 60.minutes.ago)
  end

  def is_bookmarked_by(user_id)
    Bookmark.where(user_id: user_id).where(work_id: id).count != 0
  end

end
