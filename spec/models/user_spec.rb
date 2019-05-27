# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work, type: :model do
  let!(:user) { User.create(username: 'papercloud', email: 'p@h.co', password: 'qwerty1', password_confirmation: 'qwerty1', writer: true) }
  let!(:work1) { Work.create(title: 'Hello', genre: 'bob', user_id: user.id) }
  let!(:work2) { Work.create(title: 'Hello', genre: 'bob', user_id: user.id, updated_at: 1.day.ago) }

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

end
