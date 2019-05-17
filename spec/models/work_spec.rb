# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work, type: :model do
  let!(:user) { User.create(username: 'papercloud', email: 'p@h.co', password: 'qwerty1', password_confirmation: 'qwerty1', writer: true) }
  let!(:work1) { Work.create(title: 'Hello', genre: 'bob', user_id: user.id) }
  let!(:work2) { Work.create(title: 'Hello', genre: 'bob', user_id: user.id, updated_at: 1.day.ago) }

  it 'retrieves 10 recently updated' do
    expect(Work.top_10_recent.count).to eq(2)
  end

  it 'orders them from most recent' do
    expect(Work.top_10_recent.first).to eq(work1)
  end

  it 'is not bookmarked by default' do
    expect(work1.is_bookmarked_by(user.id)).to eq(false)
  end

  it 'can check it is bookmarked' do
    user.bookmark_work(work1.id)
    expect(work1.is_bookmarked_by(user.id)).to eq(true)
  end
end
