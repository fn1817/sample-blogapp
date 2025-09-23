class CreateArticles < ActiveRecord::Migration[8.0]
  # テーブルを作るためのファイル
  def change
    create_table :articles do |t|
      # t.references = このテーブルに外部キーを追加する, :user = 対象のモデル（Railsが自動でuser_idカラムを作る）, user_idがnullだと保存しない
      t.references :user, null: false
      # カラムを追加する
      # string：短い文字列を保存
      t.string :title, null: false
      # text：長い文字列を保存
      t.text :content, null: false
      # データが作成された日付を保存する
      t.timestamps
    end
  end
end
