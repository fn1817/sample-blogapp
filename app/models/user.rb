class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # articles = ArticleモデルとRailsが解釈してくれる
  # dependent: :destroy = userが削除された時に記事も全て削除する
  has_many :articles, dependent: :destroy

  # 引数articleに入ってきた記事が対象ユーザの記事として存在するか
  def has_written?(article)
    articles.exists?(id: article.id)
  end

  # sample@sample.comの場合
  def display_name
    # ['sample', 'sample.com']に分離し、0番目の文字列をアカウント名代わりにする
    self.email.split('@').first
  end
end
