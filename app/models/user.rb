# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: { message: 'is already in use, sorry!' }, length: { minimum: 2, maximum: 12 }
  validates :email, uniqueness: { message: 'is already in use, sorry!' }

  has_many :works
  has_many :bookmarks
  has_many :claps
  has_many :bookmarked_works, through: :bookmarks, source: :work

  def writer?
    writer
  end

  def can_clap?
    (last_clap - DateTime.now) <= -9
  end

  def bookmark_work(work_id)
    Bookmark.where(user_id: id, work_id: work_id).first_or_create
  end

  def clap_work(work_id)
    can_clap? ? perform_clap(work_id) : false
  end

  def self.user_results(criteria)
    User.where('lower(username) LIKE ?', "%#{criteria.downcase}%").all.sort_by(&:updated_at).reverse!
  end


  def perform_clap(work_id)
    Clap.create!(user_id: id, work_id: work_id)
    reset_claps
    true
  end

  def reset_claps
    update(last_clap: DateTime.now)
  end

  def remove_bookmarked_work(work_id)
    Bookmark.where(user_id: id).where(work_id: work_id).destroy_all
  end

  def word_count
    count = 0
    works.each do |work|
      count += work.body.split.size
    end
    count
  end

  def clap_count
    count = 0
    works.each do |work|
      count += work.clap_count
    end
    count
  end

  def last_active
    works.top_10_recent.first.updated_at
  end
end
