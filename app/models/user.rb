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
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  has_many :received_messages, foreign_key: 'to_id', class_name: 'Message'
  has_many :sent_messages, foreign_key: 'from_id', class_name: 'Message'

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

  def following_works
    works = []
    self.following.each do |user|
      works << user.last_active_work
    end
    works.sort_by(&:updated_at).reverse!
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

  def has_unread
    result = false
    received_messages.each do |message|
      result = true if !message.read
    end
    result
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def followed_by?(other_user)
    followers.include?(other_user)
  end

  def followers_count
    followers.count
  end

  def toggle_follow(other_user)
    following?(other_user) ? unfollow(other_user) : follow(other_user)
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
    works.active.first.updated_at
  end

  def last_active_work
    works.active.first
  end

  def get_correspondence(id)
    correspondence = sent_messages.where(to_id: id) + received_messages.where(from_id: id)
    correspondence.sort_by(&:created_at).reverse!
  end
end
