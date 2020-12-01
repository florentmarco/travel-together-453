class Trip < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :messages, dependent: :destroy
end
