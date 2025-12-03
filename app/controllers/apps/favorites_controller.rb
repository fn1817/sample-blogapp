class Apps::FavoritesController < Apps::ApplicationController

    def index
        # ログインユーザがいいねしたlikesテーブル上の記事一覧を取得し、@articlesに代入
        @articles = current_user.favorite_articles
    end
end
