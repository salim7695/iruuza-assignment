# frozen_string_literal: true

module Api
  module V1
    class UserBookingsController < BaseController
      def permitted_params
        params.require(:user_booking).permit(:user_id, :book_id)
      end

      def model
        UserBooking
      end
    end
  end
end
