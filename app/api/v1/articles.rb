module V1
  class Articles < Grape::API
    helpers Auth::Authenticate
    before do
      error!({ error: { status: 403, message: "unauthorized" } }, 403) unless authenticated
    end
    resource :articles do

      desc "create articles"
      params do
        requires :title
        requires :description
      end
      post do
        article = current_user.articles.create!(declared(params))
        present article
      end

      desc "read an article"
      params do
        requires :id
      end
      get '/:id' do
        @article = Article.find(declared(params)[:id])
        authorize! :read, @article
        present @article, with: Entities::Articles
      end

      desc "update an article"
      params do
        requires :id
        requires :title
        requires :description
      end
      put '/:id' do
        article = Article.find(declared(params)[:id])
        authorize! :update, @article
        article.update!(declared(params).except(:id))
        present article
      end

      desc "delete an article"
      params do
        requires :id
      end
      delete '/:id' do
        article = Article.find(declared(params)[:id])
        authorize! :destroy, @article
        article.destroy

        status 200
      end
    end
  end
end
