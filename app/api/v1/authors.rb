module V1
  class Authors < Grape::API
    helpers Auth::Authenticate
    resource :authors do
      
      before do
        error!({ error: { status: 403, message: "unauthorized" } }, 403) unless authenticated
      end

      params do
        requires :email_id
        requires :role
      end
      post :invite do
        declared_params = declared(params, include_missing: false)
        User.invite!({ email: declared_params[:email_id], role: declared_params[:role] }, current_user)
        status 200
      end

      segment '/:author_id' do
        resource :articles do
          before do
            error!({ error: { status: 401, message: "unauthorized" } }, 401) unless authenticated
          end

          get do
            present current_user.articles, with: Entities::Articles
          end
        end
      end
    end
  end
end
