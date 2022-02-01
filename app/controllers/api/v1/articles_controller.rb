module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                articles = Article.order('created_at DESC')
                render json:{
                    status: 'success',
                    message:'loaded articles',
                    data: articles
                }, status: :ok
            end

            def show
                article = Article.find(params[:id])
                render json:{
                    status: 'success',
                    message:'loaded article',
                    data: article
                }, status: :ok
            end

            def create
                article = Article.new(articles_params)
                if article.save
                    render json:{
                        status: 'success',
                        message:'article saved',
                        data: article
                    }, status: :ok
                else
                    render json:{
                        status: 'error',
                        message:'article not saved',
                        data: article.error
                    }, status: :unprocessable_entity
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json:{
                    status: 'success',
                    message:'article deleted',
                    data: article
                }, status: :ok
            end

            def update
                article = Article.find(params[:id])
                
                if article.update_attributes(articles_params)
                    render json:{
                        status: 'success',
                        message:'article updated',
                        data: article
                    }, status: :ok
                else
                    render json:{
                        status: 'error',
                        message:'article not updated',
                        data: article.error
                    }, status: :unprocessable_entity
                end
            end

            private

            def articles_params
                params.require(:article).permit(:title, :body)
            end
        end
    end
end