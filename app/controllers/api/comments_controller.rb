class Api::CommentsController < Api::ApplicationController

    def index
        article = Article.find(params[:article_id])
        comments = article.comments
        render json: comments
    end

    def create
        # コメント対象の記事を探し、articleに代入
        article = Article.find(params[:article_id])
        # 対象の記事のcommentsコレクションの末尾に新しいCommentオブジェクトを追加
        # comment_paramsに渡された内容を元にコメントレコードを作成
        @comment = article.comments.build(comment_params)
        # リクエスト前にjavaScript側でエラーをチェックするので、リクエストがきた後は必ずsaveできるはず→!を付ける
        @comment.save!
        # Active Serializerで作成されたJSONを返す
        render json: @comment
    end

    private
    def comment_params
        # params:formから送信されるデータが入っている
        # .require(:comment):パラメータの中にcommentというキーが必要です
        # .permit(:content):commentキーの中でcontentのみ許可します
        params.require(:comment).permit(:content)
        # {comment: {content: 'aaa'}}となっている必要がある
    end
end
