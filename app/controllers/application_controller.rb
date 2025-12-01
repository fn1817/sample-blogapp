class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  # コントローラーが実行される前に言語を書き換えるメソッドを定義
  # 全てのコントローラーはApplicationControllerを継承しているので、全てのアクションが実行される前に言語が書き換わる（全てのページ(view)で設定言語が反映される）
  before_action :set_locale

  def current_user
    # Deviseが定義しているcurrent_userが存在していれば（=ログインしている時だけ実行）current_userをdecorateして（モデルに見た目や表示用のメソッドを追加して使えるようにしてから）current_userを返す
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  # デフォルトでApplicationControllerで必ず実行されるため、before_actionで指定する必要はない
  # RailsがURLを生成するときに毎回呼ばれる
  def default_url_options
    # ブラウザの初期URL末尾にデフォルトの言語設定をつける
    # I18n.locale = set_localeでI18n.localeに代入された値が入る
    # Railsはdefault_url_optionsで返されたハッシュを見て、URLパラメータとして自動で追加している（?locale=I18n.localeの値）
    { locale: I18n.locale }
  end

  private
  def set_locale
    # URL末尾のパラメータを取得（値の代入だけでURLは生成しない）
    # || = localeがなかったらデフォルト言語（application.rbに記載）を使う
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
