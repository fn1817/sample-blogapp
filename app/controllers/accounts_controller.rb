class AccountsController < ApplicationController
    def show
        # URLに含まれているidを使って、Usersテーブルからそのユーザーを探す
        @user = User.find(params[:id])
        # もし記事を作成したユーザとログインユーザが同じだったら
        if @user == current_user
            # プロフィール編集画面にリダイレクト
            redirect_to profile_path
        end
    end
end
