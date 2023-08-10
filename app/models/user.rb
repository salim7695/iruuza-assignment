# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_bookings, dependent: :destroy
  has_many :books, through: :user_bookings

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  scope :search_by_name, ->(value) { where('MATCH (name) AGAINST (?)', value) }
end
