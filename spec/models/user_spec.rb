# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(username: 'papercloud', email: 'p@h.co', password: 'qwerty1', password_confirmation: 'qwerty1', writer: true) }
  let!(:user2) { User.create(username: 'bob', email: 'bob@h.co', password: 'qwerty1', password_confirmation: 'qwerty1', writer: true) }
  let!(:work1) { Work.create(title: 'Hello', body: 'well well well well, well well', genre: 'bob', user_id: user.id) }
  let!(:work2) { Work.create(title: 'Hello', body: 'indeed', genre: 'bob', user_id: user.id, updated_at: 1.day.ago) }
  let!(:message) { Message.create(to_id: user.id, from_id: user2.id, message: 'hello') }

  it 'can bookmark a work' do
    user.bookmark_work(work1.id)
    expect(user.bookmarked_works).to eq([work1])
  end

  it 'can remove a bookmark' do
    user.bookmark_work(work1.id)
    user.bookmark_work(work2.id)
    user.remove_bookmarked_work(work1.id)
    expect(user.bookmarked_works).to eq([work2])
  end

  it 'can clap a work' do
    user.clap_work(work1.id)
    expect(user.can_clap?).to eq(false)
    work = Work.find_by_id(work1.id)
    expect(work.clap_count).to eq(1)
  end

  it 'returns false if can not clap' do
    expect(user.clap_work(work1.id)).to eq(true)
    expect(user.clap_work(work1.id)).to eq(false)
  end

  it 'returns all time word count' do
    expect(user.word_count).to eq(7)
  end

  it 'returns all time clap count' do
    user.clap_work(work1.id)
    expect(user.clap_count).to eq(1)
  end

  it 'returns last active' do
    expect(user.last_active).to eq(work1.updated_at)
  end

  it 'can be followed' do
    user2.following << user
    expect(user2.following?(user)).to eq(true)
  end

  it 'knows when being followed' do
    user2.follow(user)
    expect(user.followed_by?(user2)).to eq(true)
  end

  it 'can toggle follow/unfollow' do
    expect(user.followed_by?(user2)).to eq(false)
    user2.toggle_follow(user)
    expect(user.followed_by?(user2)).to eq(true)
    user2.toggle_follow(user)
    expect(user.followed_by?(user2)).to eq(false)
  end

  it 'can display follower count' do
    user2.following << user
    expect(user.followers_count).to eq(1)
  end

  it 'will return true if unread messages' do
    expect(user2.has_unread).to eq(false)
    expect(user.has_unread).to eq(true)
  end
end
