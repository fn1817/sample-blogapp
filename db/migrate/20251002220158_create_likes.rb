class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.timestamps
      # t.references = このテーブルに外部キーを追加する, :user, article = 対象のモデル（Railsが自動でuser_id, article_idカラムを作る）, user_id, article_idがnullだと保存しない
      t.references :user, null: false
      t.references :article, null: false
    end
  end
end
