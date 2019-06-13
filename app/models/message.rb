class Message < ApplicationRecord
  belongs_to :message_sender, foreign_key: 'from_id', class_name: 'User'
end
