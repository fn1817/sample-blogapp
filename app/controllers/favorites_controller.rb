class FavoritesController < ApplicationController
    # ログインしていないと使えないようにする
    before_action :authenticate_user!

    def index
        # ログインユーザがいいねしたlikesテーブル上の記事一覧を取得し、@articlesに代入
        @articles = current_user.favorite_articles
    end
end
