class RelationshipMailer < ApplicationMailer
  # メソッド一つ一つにviewが存在する
  # 新しいフォロワーができたというメソッド
  def new_follower(user, follower)
    # インスタンス変数を定義して、viewで使えるようにする
    @user = user
    @follower = follower
    # どこにメールを送るか指定する
    mail to: user.email, subject: '【お知らせ】フォローされました'
  end
end
