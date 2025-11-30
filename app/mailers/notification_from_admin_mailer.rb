class NotificationFromAdminMailer < ApplicationMailer
    def notify(user, msg)
      @msg = msg
      # どこにメールを送るか指定する
      mail to: user.email, subject: '【お知らせ】'
    end
end
