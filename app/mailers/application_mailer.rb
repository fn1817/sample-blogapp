class ApplicationMailer < ActionMailer::Base
  # default from: xx = xxからメールを送信する
  default from: 'sandboxa632faec6a7c4880b081ccaba8cef8b4.mailgun.org'
  # views > layouts > mailer.html.haml（HTMLでメール送付）とmailer.text.haml（テキストでメール送付）をテンプレートとしてメールを作成する
  layout 'mailer'
end
