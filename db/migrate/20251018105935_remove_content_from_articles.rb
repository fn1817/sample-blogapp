class RemoveContentFromArticles < ActiveRecord::Migration[8.0]
  def change
    # articlesテーブルからcontentカラムを削除（rollbackできるようにデータ型も記述すること）
    remove_column :articles, :content, :text
  end
end
