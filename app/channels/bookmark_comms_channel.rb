class BookmarkCommsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bookmark_comms_channel_#{params[:work]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def mark
    current_user.bookmark_work(params[:work])
  end
end
