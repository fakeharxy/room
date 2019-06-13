# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    load_messages
  end

  def mark_read
    load_message
    @message.update(read: true)
    redirect_to messages_url
  end

  def destroy
    load_message
    @message.destroy
    redirect_to messages_url
  end

  def create
    Message.create(message_params)
    redirect_to "/users/#{params[:message][:to_id]}"
  end

  private

  def load_messages
    @messages = current_user.received_messages.sort_by { |a| [a.read ? 0 : 1, a.created_at] }.reverse!
  end

  def load_message
    @message ||= Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:message, :to_id).merge(from_id: current_user.id)
  end
end
