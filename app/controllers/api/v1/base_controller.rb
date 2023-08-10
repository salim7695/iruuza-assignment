module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

      skip_before_action :verify_authenticity_token

      def index
        render json: success_response(results)
      end

      def create
        if new_resource.save
          render json: success_response(new_resource), status: :created
        else
          render json: { message: new_resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def permitted_params; end

      private

      def serializer; end

      def model; end

      def success_response(record)
        { model.to_s.underscore => ActiveModelSerializers::SerializableResource
          .new(record, each_serializer: serializer)
          .as_json,
          success: true }
      end

      def results
        @results ||= resources
      end

      def resources
        @resources ||= model.all
      end

      def new_resource
        @new_resource ||= model.new(permitted_params)
      end

      def record_not_unique
        render json: { message: 'Record already exists.' }, status: :unprocessable_entity
      end

      def record_not_found
        render json: { message: 'Record not found.' }, status: :not_found
      end
    end
  end
end
