module V1
  module Auth
    module Authenticate

      def authenticated
        return true if @authenticated

        @authenticated = false
        authenticate_user
        if @authenticated
          return true
        else
          return false
        end
      end

      def authenticate_user
        if request.headers['Authorization'].present?
          begin
            token = request.headers["Authorization"].sub("Bearer ", "")
            jwt_payload = JWT.decode(token, "e20c4c376b4830e0e50031f36389eabbbcb5e6d240844c63e4ded769c3950e59d1fb5ee94b799c9df8f79ca855fcff8bd54850d966a627fa7f1d0715a176a791").first
  
            @current_user = User.find(jwt_payload['sub'])
            @authenticated = true if @current_user
          rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
            return
          end
        end
      end

      def current_user
        @current_user
      end
    end
  end
end
