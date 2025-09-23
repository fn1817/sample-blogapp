# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#

class Article < ApplicationRecord
    # titleが入力されていないと保存しません
    # ApplicationRecordが保存しないだけでSQLは関係ない
    validates :title, presence: true
    # titleが2文字以上100文字以下でないと保存しません
    validates :title, length: { minimum: 2, maximum: 100 }
    # titleの先頭の文字が@だと保存しません
    validates :title, format: { with: /\A(?!\@)/ }

    # contentが入力されていないと保存しません
    validates :content, presence: true
    # contentが10文字以上ないと保存しません
    validates :content, length: { minimum: 10 }
    # contentが他のレコードと重複していると保存しません
    validates :content, uniqueness: true

    # 独自ルールの作成
    validate :validate_title_and_content_length

    # comments = CommentモデルとRailsが解釈してくれる
    # dependent: :destroy = 記事が削除された時にコメントも全て削除する
    has_many :comments, dependent: :destroy

    # 記事はuserモデルに所属している
    belongs_to :user

    # 記事を作成した日付の表示
    def display_created_at
        I18n.l(self.created_at, format: :default)
    end

    def author_name
        # belongs_to :userでuserと紐づいているので、userも取得可能
        user.display_name
    end

    private
    def validate_title_and_content_length
        # titleとcontentの文字総数を変数に代入
        char_count = self.title.length + self.content.length
        # titleとcontentの文字総数が100文字より大きくない場合（100以下）
        errors.add(:content, '100文字より大きくしてください') unless char_count > 100
    end
end
