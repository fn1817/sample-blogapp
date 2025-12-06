# rakeタスクは複数作成できるため、グループ（名前空間）分けする
namespace :notification do
  # rakeタスクの説明
  desc '利用者にメールを送付する'

  # environment = Railsの環境を読み込んでから実行する（UserモデルやActionMailerなどが使える状態になる）
  # args（=arguments(引数)）に引数['msg']の内容が渡ってくる
  task :send_emails_from_admin, [ 'msg' ] => :environment do |task, args|
    msg = args['msg']
    # msgが存在したら、メール通知する
    if msg.present?
      NotificationFromAdminJob.perform_later(msg)
    else
      puts '送信できませんでした。メッセージを入力してください。ex. rails notification:send_emails_from_admin\[こんにちは\]'
    end
  end
end
