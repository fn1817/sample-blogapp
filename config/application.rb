require_relative 'boot'

require 'rails/all'

# Railsの実行環境がdevelopmentまたはtestなら、.envファイルを読み込んで環境変数を設定する
# if ['development', 'test'].include? ENV['RAILS_ENV']
#   Dotenv::Railtie.load
# end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blogapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Active Storageが画像加工するときにMiniMagickという画像処理ライブラリを使うように設定（ImageMagickソフト（C言語）をRuby経由で操作）
    config.active_storage.variant_processor = :mini_magick

    # .envファイルを読み込む
    # if Rails.env.development? || Rails.env.test?
      # 現在のRails環境に対応するGemfileのgemを全てロードする
      # Bundler.require(*Rails.groups)
      # Rails起動時にdotenvも読み込む
      # Dotenv::Railtie.load
    # end

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # デフォルトの言語は日本語であることを指定
    config.i18n.default_locale = :ja
    # Sidekiqを使う指定
    config.active_job.queue_adapter = :sidekiq
  end
end
