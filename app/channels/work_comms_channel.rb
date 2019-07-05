# frozen_string_literal: true

class WorkCommsChannel < ApplicationCable::Channel
  include WorksHelper

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

  def tweet
    @work = Work.find_by_id(params[:work])
    if @work.user.can_tweet?
      set_up_twitter
      send_update_to_twitter
    end
  end

  private

  def send_update_to_twitter
      if ENV['RAILS_ENV'] == 'production'
        @client.update("#{@work.user.username} is adding to their project titled #{@work.title} on app.writeroom.online! You should check out what they are adding. #writeroom #writing #amwriting")
      end
      @work.user.has_tweeted
  end

end
