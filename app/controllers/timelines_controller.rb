class TimelinesController < ApplicationController
# ログインしていなければ処理を止めてログイン画面にリダイレクト（未ログインの場合、showアクションは実行されない）
before_action :authenticate_user!

    # 自分がフォローしているユーザの記事一覧を取得する
    def show
        # ログインユーザがフォローしている全てのユーザのidを取得
        # pluck = 指定したカラムの値だけを配列で取得する
        user_ids = current_user.followings.pluck(:id)
        # 記事全体の中で、フォローしているユーザの記事だけ取得（配列を渡すとor検索になる）
        @articles = Article.where(user_id: user_ids)
    end
end
