class ApplicationMailer < ActionMailer::Base
  # default from: xx = xxからメールを送信する
  default from: 'from@example.com'
  # views > layouts > mailer.html.haml（HTMLでメール送付）とmailer.text.haml（テキストでメール送付）をテンプレートとしてメールを作成する
  layout 'mailer'
end
