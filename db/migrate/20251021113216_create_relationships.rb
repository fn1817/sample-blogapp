class CreateRelationships < ActiveRecord::Migration[8.0]
  def change
    create_table :relationships do |t|
      # following_id, follower_idカラムを追加
      # 外部キーを指定（following_id, follower_idがusersテーブルと関係する値であることをDBに対して示す）
      t.references :following, null: false, foreign_key: { to_table: :users }
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
