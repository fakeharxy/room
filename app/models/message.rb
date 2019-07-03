class Message < ApplicationRecord
  belongs_to :message_sender, foreign_key: 'from_id', class_name: 'User'

  def message_receiver
    User.find_by_id(to_id)
  end
end
