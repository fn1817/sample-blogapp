class CreateArticles < ActiveRecord::Migration[8.0]
  # テーブルを作るためのファイル
  def change
    create_table :articles do |t|
      # カラムを追加する
      # string：短い文字列を保存
      t.string :title
      # text：長い文字列を保存
      t.text :content
      # データが作成された日付を保存する
      t.timestamps
    end
  end
end
