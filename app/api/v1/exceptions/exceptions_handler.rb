module V1
  module Exceptions
    module ExceptionsHandler
      extend ActiveSupport::Concern

      included do

        rescue_from ::CanCan::AccessDenied do
          error!({ error: { status: 403, message: "Forbidden"} }, 403)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          field_errors = e.record.errors.messages
          error_messages = field_errors.values.flatten
          error!({ error: { status: 422, message: error_messages.size == 1 ? error_messages[0] : "Invalid Records", field_errors: e.record.errors.messages } },
                 422)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error!({ error: { status: 404, message: "Not Found" } }, 404)
        end
      end
    end
  end
end