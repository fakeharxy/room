# frozen_string_literal: true

class WorkCommsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "work_comms_channel_#{params[:work]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @work = Work.find_by_id(params[:work])
    @work.update(body: data['message'])
    ActionCable.server.broadcast "work_comms_channel_#{params[:work]}",
                                 message: markdown_to_html(data['message'])
  end

  def markdown_to_html(text)
    Kramdown::Document.new(text).to_html
  end
end
