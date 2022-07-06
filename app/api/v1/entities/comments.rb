module V1
  module Entities
    class Comments < Base
      expose :id
      expose :comment
      expose :author, using: Entities::Authors
      with_options(format_with: :date) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end
