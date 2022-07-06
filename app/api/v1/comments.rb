module V1
  class Comments < Grape::API
    helpers Auth::Authenticate
    before do
      error!({ error: { status: 401, message: "unauthorized" } }, 401) unless authenticated
    end

    resources :comments do
      params do
        requires :comment
        requires :article_id
      end
      post do
        debugger
        comment = current_user.comments.create!(declared(params))
        present comment
      end

      params do
        requires :id
      end
      get '/:id' do
        comment = Comment.find(declared(params)[:id])
        present comment
      end

      params do
        requires :id
        requires :comment
        requires :article_id
      end
      put '/:id' do
        @comment = Comment.find(declared(params)[:id])
        authorize! :update, @comment
        @comment.update!(declared(params).except(:id))
      end

      params do
        requires :id
      end
      delete '/:id' do
        @comment = Comment.find(declared(params)[:id])
        authorize! :destroy, @comment
        comment.destroy

        status 200
      end
    end
  end
end
