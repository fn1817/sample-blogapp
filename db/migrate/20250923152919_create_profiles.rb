class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      # t.references = このテーブルに外部キーを追加する, :user = 対象のモデル（Railsが自動でuser_idカラムを作る）, user_idがnullだと保存しない
      t.references :user, null: false
      # ニックネーム
      t.string :nickname
      # 自己紹介（長文の場合はtext）
      t.text :introduction
      # 性別（整数）
      t.integer :gender
      # 生年月日
      t.date :birthday
      # 通知設定（デフォルトでは何も入力されていなければfalse）
      t.boolean :subscribed, default: false
      t.timestamps
    end
  end
end
