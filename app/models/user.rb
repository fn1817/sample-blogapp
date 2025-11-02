class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # articles = ArticleモデルとRailsが解釈してくれる
  # dependent: :destroy = userが削除された時に記事も全て削除する
  # Active Recordがuser.articlesメソッド（関連するarticlesレコードを返す）を自動で使えるようにしてくれる
  has_many :articles, dependent: :destroy

  # likes = LikeモデルとRailsが解釈してくれる
  # dependent: :destroy = userが削除された時にいいねも全て削除する
  # Active Recordがuser.likesメソッド（関連するlikesレコードを返す）を自動で使えるようにしてくれる
  has_many :likes, dependent: :destroy
  # ログインユーザがいいねした記事だけを取得できる（Active Recordがuser.favorite_articlesメソッドを自動で使えるようにしてくれる）
  # through: likes = 中間（likes）テーブルを通して記事を取得できる
  # source: :article = favorite_articlesはarticleであることを示す（Likeモデルのbelongs_to :articleを通してArticleを取得する）
  # has_many :articles, through: likesでも良いが、「has_many :articles, dependent: :destroy」（ログインユーザが作成した記事）と混同しやすいのでfavorite_articlesを使う
  has_many :favorite_articles, through: :likes, source: :article

  # 自分がフォロワーになっている値（=follower_idが自分のuser_id）を取得すれば、自分がフォローしている人がわかる
  # （User has_many :likesとすると、Railsはlikesテーブルのuser_idが外部キーと判断してくれるが、Relationshipsテーブルにはuser_idがないため）外部キーを指定する必要がある
  # following_relationshipというモデルはないので、Relationshipモデルであることを明示する
  # dependent: :destroy = userが削除された時にフォローも全て削除する
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  # 自分がフォローしている人を取得するには、relationshipsテーブルを通してfollowing_idを取得する必要がある
  has_many :followings, through: :following_relationships, source: :following

  # 自分がフォローされている値（=following_idが自分のuser_id）を取得すれば、自分をフォローしている人がわかる
  # （User has_many :likesとすると、Railsはlikesテーブルのuser_idが外部キーと判断してくれるが、Relationshipsテーブルにはuser_idがないため）外部キーを指定する必要がある
  # follower_relationshipsというモデルはないので、Relationshipモデルであることを明示する
  # dependent: :destroy = userが削除された時にフォローも全て削除する
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  # 自分をフォローしている人を取得するには、relationshipsテーブルを通してfollower_idを取得する必要がある
  has_many :followers, through: :follower_relationships, source: :follower

  # profile = ProfileモデルとRailsが解釈してくれる
  # Active Recordがuser.profileメソッド（関連するProfileレコードを返す）を自動で使えるようにしてくれる
  has_one :profile, dependent: :destroy

  # Profileモデルからメソッドを持ってくる
  # allow_nil: trueでぼっち演算子と同じくnilでもエラーを回避できる
  delegate :birthday, :age, :gender, to: :profile, allow_nil: true

  # 引数articleに入ってきた記事が対象ユーザの記事として存在するか
  def has_written?(article)
    articles.exists?(id: article.id)
  end

  # 引数articleに入ってきた記事を対象ユーザ（メソッド呼び出し元のユーザ）がいいねしているか
  def has_liked?(article)
    likes.exists?(article_id: article.id)
  end

  # 例外が発生するメソッドであることを明示するために!をつけている
  def follow!(user)
    # get_user_idメソッドの呼び出し
    user_id = get_user_id(user)
    # 外部キー（follower_id）は自動で自分が指定される
    # 引数で指定したuserをフォローする
    # 自分（follower_id）がフォローする関係（Relationship）を1件作る
    following_relationships.create!(following_id: user_id)
  end

  # 例外が発生するメソッドであることを明示するために!をつけている
  def unfollow!(user)
    # get_user_idメソッドの呼び出し
    user_id = get_user_id(user)
    # 外部キー（follower_id）は自動で自分が指定される
    # 引数で指定したuserのフォローを外す
    # find_by!で例外が発生したら処理を止める（本来、自分がフォローしていないユーザのフォローを外すことはありえないので、必ず対象ユーザが見つかることを前提に!をつけている）
    relation = following_relationships.find_by!(following_id: user_id)
    # destroy!は削除されるのが通常なので!をつけている
    relation.destroy!
  end

  # Followをしているか/していないかをチェックするメソッド
  def has_followed?(user)
    # 自分がFollowしている人達の中に存在するか
    following_relationships.exists?(following_id: user.id)
  end

  # def birthday
  #   # profileがnilなら何も表示されない（空白）
  #   profile&.birthday
  # end

  # def gender
  #   # profileがnilなら何も表示されない（空白）
  #   profile&.gender
  # end

  # user.xx（メソッド名）でメソッドを使える
  def prepare_profile
    # (self.)profile || (self.)build_profile
    profile || build_profile
  end

  private
  # follow!メソッドとunfollow!メソッドでしか使わないので、privateにする
  def get_user_id(user)
    # もし渡ってきた引数userがUserクラスのインスタンスだったら
    if user.is_a?(User)
      # user.idを返す
      user.id
    else
      # 渡ってきた引数userがuser_idだったらそのまま返す
      user
    end
  end
end
