# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :user_bookings, dependent: :destroy
  has_many :users, through: :user_bookings

  validates :title, :description, :author_id, presence: true

  delegate :name, to: :author, prefix: true

  scope :search_by_users, ->(user_ids) { includes(:user_bookings).where(user_bookings: { user_id: user_ids }) }
  scope :search_by_title, ->(value) { where('MATCH (title) AGAINST (?)', value) }
  scope :search_by_description, ->(value) { where('MATCH (description) AGAINST (?)', value) }
  scope :search_by_title_description, ->(value) { where('MATCH (title, description) AGAINST (?)', value) }
end
