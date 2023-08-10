# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/user_bookings_controller', type: :request do
  path '/api/v1/user_bookings' do
    post 'Create UserBooking' do
      tags 'UserBooking'

      produces 'application/json'
      consumes 'application/json'

      parameter in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          book_id: { type: :integer }
        }
      }

      response '200', 'UserBooking created' do
        run_test!
      end
    end
  end
end
