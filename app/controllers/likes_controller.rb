class LikesController < ApplicationController
    # ログインしていないと使えないようにする
    before_action :authenticate_user!

    def create
        # 表示されている記事のレコードを取得
        article = Article.find(params[:article_id])
        # article has_many :likesなので、createが使える
        # create! = 内容に不備があるとエラーが発生し、処理が止まる（必ず処理をしたい場合に使用）
        # この記事に対してログインユーザがいいねしたというレコードをlikesテーブルに保存
        article.likes.create!(user_id: current_user.id)
        # いいねできたら、同じ画面に遷移する
        redirect_to article_path(article)
    end

    def destroy
        # 表示されている記事のレコードを取得
        article = Article.find(params[:article_id])
        # この記事に対してログインユーザがいいねしたレコードを探す
        # find_by! = 必ず処理をしたい場合に使用（destroyするときは必ずいいねがあるはず）
        like = article.likes.find_by!(user_id: current_user.id)
        # この記事に対してログインユーザがいいねしたレコードを削除
        like.destroy!
        # 削除できたら、同じ画面に遷移する
        redirect_to article_path(article)
    end
end
