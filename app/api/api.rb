class API < Grape::API
  version 'v1', using: :path
  prefix 'api'
  format :json
  content_type :json, "application/json; charset=utf-8"

  # mounting routes
  mount V1::Root
end
