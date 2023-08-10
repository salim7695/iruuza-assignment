class UserBooking < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :user_id, :book_id, presence: true
  validates :book_id, uniqueness: { scope: :user_id }
end
