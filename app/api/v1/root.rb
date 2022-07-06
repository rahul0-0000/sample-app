module V1
  class Root < Grape::API
    include Exceptions::ExceptionsHandler

    # mounting routes
    mount Articles
    mount Authors
    mount Comments
  end
end
