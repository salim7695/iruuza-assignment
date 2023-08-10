# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/books_controller', type: :request do
  path '/api/v1/books' do
    get 'Returns books' do
      tags 'Books'

      produces 'application/json'
      consumes 'application/json'

      security [apikey: []]

      parameter name: :body, in: :query, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          name: { type: :string },
          query: { type: :string },
        }
      }

      response '200', 'result' do
        run_test!
      end
    end
  end
end
