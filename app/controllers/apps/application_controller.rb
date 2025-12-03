class Apps::ApplicationController < ApplicationController
  # ログインしていなければ処理を止めてログイン画面にリダイレクト（未ログインの場合、指定したアクションは実行されない）
  before_action :authenticate_user!
end
