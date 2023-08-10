# frozen_string_literal: true

module Api
  module V1
    class BooksController < BaseController
      private

      def results
        @results ||= BookQueryObject.new(Book.includes(:author).all, filter_params).results
      end

      def filter_params
        params.permit(:name, :title, :description, :query)
      end

      def serializer
        BookSerializer
      end

      def model
        Book
      end
    end
  end
end
