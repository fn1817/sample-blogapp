# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#

class Article < ApplicationRecord
    # has_one_attached:Active Storageのメソッドで、モデルに「1つのファイルを添付できる」ことを宣言
    # Articleでアイキャッチ画像をアップロード・取得できるようにする
    has_one_attached :eyecatch

    # Artilcleでcontentをリッチテキストで使えるようにする
    has_rich_text :content

    # titleが入力されていないと保存しません
    # ApplicationRecordが保存しないだけでSQLは関係ない
    validates :title, presence: true
    # titleが2文字以上100文字以下でないと保存しません
    validates :title, length: { minimum: 2, maximum: 100 }
    # titleの先頭の文字が@だと保存しません（Brakemanの脆弱性を修正）
    validates :title, format: { with: /\A[^@].*\z/ }

    # contentが入力されていないと保存しません
    validates :content, presence: true
    # # contentが10文字以上ないと保存しません
    # validates :content, length: { minimum: 10 }
    # # contentが他のレコードと重複していると保存しません
    # validates :content, uniqueness: true

    # # 独自ルールの作成
    # validate :validate_title_and_content_length

    # comments = CommentモデルとRailsが解釈してくれる
    # dependent: :destroy = 記事が削除された時にコメントも全て削除する
    has_many :comments, dependent: :destroy

    # likes = LikeモデルとRailsが解釈してくれる
    # dependent: :destroy = articleが削除された時にいいねも全て削除する
    # Active Recordがarticle.likesメソッド（関連するlikesレコードを返す）を自動で使えるようにしてくれる
    has_many :likes, dependent: :destroy

    # 記事はuserモデルに所属している
    belongs_to :user

  # private
  # def validate_title_and_content_length
  #     # titleとcontentの文字総数を変数に代入
  #     char_count = self.title.length + self.content.length
  #     # titleとcontentの文字総数が100文字より大きくない場合（100以下）
  #     errors.add(:content, '100文字より大きくしてください') unless char_count > 100
  # end
end
