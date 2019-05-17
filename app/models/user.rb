# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, :email, uniqueness: { message: "is already in use, sorry!" }

  has_many :works
  has_many :bookmarks
  has_many :bookmarked_works, through: :bookmarks, source: :work

  def writer?
    writer
  end

  def bookmark_work(work_id)
    Bookmark.where(user_id: id, work_id: work_id).first_or_create
  end

  def remove_bookmarked_work(work_id)
    Bookmark.where(user_id: id).where(work_id: work_id).destroy_all
  end
end
