class Chatroom < ApplicationRecord
  belongs_to :trip
  has_many :messages, dependent: :destroy
end
