# RailsアプリをPumaサーバで起動する設定（RailsではPumaがデフォルトのアプリケーションサーバだが、HEROKUは内部構造を知らないので、明示する）
web: bundle exec puma -C config/puma.rb
# worker（sidekiq）の設定を追加
worker: bundle exec sidekiq
# release（=デプロイ）が成功したらmigrationを実行する
release: bundle exec rake db:migrate
