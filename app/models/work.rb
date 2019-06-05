# frozen_string_literal: true

class Work < ApplicationRecord
  validates :title, :genre, presence: { message: 'must be filled in!' }
  validates :title, :genre, length: { maximum: 20 }
  belongs_to :user
  has_many :bookmarks
  has_many :claps

  def self.top_10_recent
    Work.order('updated_at DESC').limit(10)
  end

  def self.active
    Work.where('updated_at > ?', 60.minutes.ago).sort_by(&:updated_at).reverse!
  end

  def self.popular
    Work.joins(:claps).where('claps.created_at > ?', 1.day.ago).uniq.last(10).sort_by(&:day_clap_count).reverse!
  end

  def self.genre_results(criteria)
    Work.where('lower(genre) LIKE ?', "%#{criteria.downcase}%").all.sort_by(&:day_clap_count).reverse!
  end

  def is_bookmarked_by(user_id)
    Bookmark.where(user_id: user_id).where(work_id: id).count != 0
  end

  def clap_count
    claps.count
  end

  def day_clap_count
    claps.where('created_at > ?', 1.day.ago).count
  end
end
