# frozen_string_literal: true

class BookmarkCommsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bookmark_comms_channel_#{params[:work]}"
  end

  def unsubscribed; end

  def mark
    current_user.bookmark_work(params[:work])
  end

  def clap
    Work.find_by_id(params[:work]).increment!(:claps)
    send_clap
  end

  def update_view_count
    count = channels_count
    ActionCable.server.broadcast "bookmark_comms_channel_#{params[:work]}",
                                 view_count: count
  end

  def send_clap
    ActionCable.server.broadcast "bookmark_comms_channel_#{params[:work]}",
                                 clap: true
  end

  def channels_count
    pubsub = ActionCable.server.pubsub
    pubsub.send(:listener)
          .instance_variable_get('@subscribers')["bookmark_comms_channel_#{params[:work]}"]
          .count - 1
  end
end
