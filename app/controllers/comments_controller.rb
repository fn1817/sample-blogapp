class CommentsController < ApplicationController
    def new
        # comments#newのURLは/articles/:article_id/comments/newなので、記事のidはarticle_idで取得できる
        article = Article.find(params[:article_id])
        @comment = article.comments.build
    end

    def create
        # コメント対象の記事を探し、articleに代入
        article = Article.find(params[:article_id])
        # comment_paramsに渡された内容を元にコメントレコードを作成
        # renderする時に@comment（インスタンス変数）として定義しておかないと、new.html.hamlで@commentを使用しているのでエラーになる
        @comment = article.comments.build(comment_params)
        # もしDBに値が保存されれば、コメントした記事のページ（articles#show）に飛ぶ
        if @comment.save
            # オブジェクトを渡しているのにidに展開されるのはRailsが自動でやってくれているから
            redirect_to article_path(article), notice: 'コメントを追加'
        else
            flash.now[:error] = '更新できませんでした'
            # render :new→同じリクエストのままcomments > new.html.hamlを表示し直す=formの内容は入ったまま再表示
            # status: :unprocessable_entity→バリデーションエラー（必須項目が空など）のときにHTTPステータスコード422を返す
            render :new, status: :unprocessable_entity
        end
    end

    private
    def comment_params
        # params:formから送信されるデータが入っている
        # .require(:comment):パラメータの中にcommentというキーが必要です
        # .permit(:content):commentキーの中でcontentのみ許可します
        params.require(:comment).permit(:content)
    end
end
