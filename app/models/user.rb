class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :guests
  has_many :votes
  has_many :trips
  has_many :comments
  has_many :tasks
  has_many :items

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
