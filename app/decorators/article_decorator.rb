module ArticleDecorator
  # 記事を作成した日付の表示
  def display_created_at
      I18n.l(self.created_at, format: :default)
  end

  # いいね数をカウントするメソッド
  def like_count
      # countはActiveRecord側で用意されているメソッド（likesが1つもなければ0を返す）
      likes.count
  end

  def author_name
      # belongs_to :userでuserと紐づいているので、userも取得可能
      user.display_name
  end
end
