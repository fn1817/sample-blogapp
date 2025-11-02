class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  def current_user
    # Deviseが定義しているcurrent_userが存在していれば（=ログインしている時だけ実行）current_userをdecorateして（モデルに見た目や表示用のメソッドを追加して使えるようにしてから）current_userを返す
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end
end
