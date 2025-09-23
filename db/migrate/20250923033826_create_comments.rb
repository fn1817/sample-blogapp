class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      # t.references = このテーブルに外部キーを追加する, :article = 対象のモデル（Railsが自動でarticle_idカラムを作る）, article_idがnullだと保存しない
      t.references :article, null: false
      # contentカラムの追加
      t.text :content, null: false
      t.timestamps
    end
  end
end
