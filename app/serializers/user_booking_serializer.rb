# frozen_string_literal: true

class UserBookingSerializer < BaseSerializer
  belongs_to :user, serializer: UserSerializer
  belongs_to :book, serializer: BookSerializer
end
