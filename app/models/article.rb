class Article < ApplicationRecord
    # titleが入力されていないと保存しません
    validates :title, presence: true
    # contentが入力されていないと保存しません
    validates :content, presence: true

    # 記事を作成した日付の表示
    def display_created_at
        I18n.l(self.created_at, format: :default)
    end
end
