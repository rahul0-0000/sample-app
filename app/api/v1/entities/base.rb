module V1
  module Entities
    class Base < Grape::Entity
      format_with :date do |date|
        date.nil? ? date : date.to_date.strftime("%Y-%m-%d")
      end
    end
  end
end