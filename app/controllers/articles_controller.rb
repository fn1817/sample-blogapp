class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
        # URL「/articles/:id」の「:id」をparamsで取得し、Articleの該当id行データを取得
        @article = Article.find(params[:id])
    end
end
