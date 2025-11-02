class FollowsController < ApplicationController
    # ログインしていなければ処理を止めてログイン画面にリダイレクト（未ログインの場合、createアクションは実行されない）
    before_action :authenticate_user!

    def create
        # 引数で指定したユーザをFollowする
        current_user.follow!(params[:account_id])
        # 引数で指定したユーザプロフィールにリダイレクトする
        redirect_to account_path(params[:account_id])
    end
end
