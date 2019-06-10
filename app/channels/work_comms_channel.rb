# frozen_string_literal: true

class WorkCommsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "work_comms_channel_#{params[:work]}" if current_user.id != Work.find_by_id(params[:work]).user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @work = Work.find_by_id(params[:work])
    @work.update(body: data['message'])
    message = data['message'].gsub('~', '<span id="scrollPos"/>')
    ActionCable.server.broadcast "work_comms_channel_#{params[:work]}",
      message: message
  end

  def markdown_to_html(text)
    Kramdown::Document.new(text).to_html
  end
end
