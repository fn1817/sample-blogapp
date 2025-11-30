class NotificationFromAdminJob < ApplicationJob
  # どのキューに割り振るか指定
  queue_as :default

  # ジョブを実行した時にperform内の処理が実行される（必ず記述する必要あり）
  def perform(msg)
    # 全てのユーザにメール通知する
    User.all.each do |user|
      # NotificationFromAdminMailerのnotifyメソッドを実行（非同期）
      NotificationFromAdminMailer.notify(user, msg).deliver_later
    end
  end
end
