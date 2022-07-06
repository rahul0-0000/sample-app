class SessionsController < Devise::SessionsController
  respond_to :json
  
  private
  
  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: 'Logged In' }, status: :ok
    else
      render json: { message: 'Logged In Failed' }, status: :ok
    end
  end
end
