class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # articles = ArticleモデルとRailsが解釈してくれる
  # dependent: :destroy = userが削除された時に記事も全て削除する
  # Active Recordがuser.articlesメソッド（関連するarticlesレコードを返す）を自動で使えるようにしてくれる
  has_many :articles, dependent: :destroy
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

  # sample@sample.comの場合
  def display_name
    # ['sample', 'sample.com']に分離し、0番目の文字列をアカウント名代わりにする
    # user.profile.nicknameがある場合はそれを表示し、ない場合は上記を表示する
    # ||は左辺を評価して、当てはまらなかったら右辺を実行する
    # この場合、profileがnilだとnil.nicknameでエラーとなるので、別の書き方をする
    # profile.nickname || self.email.split('@').first

    # # もしプロフィールが存在するかつ、nicknameがあれば
    # if profile && profile.nickname
    #   # nicknameを表示
    # 	profile.nickname
    # else
    # 	# ['sample', 'sample.com']に分離し、0番目の文字列をアカウント名代わりにする
    #   self.email.split('@').first
    # end
    # もしプロフィールが存在するかつ、nicknameがあればnicknameを表示、そうでなければ['sample', 'sample.com']に分離し、0番目の文字列をアカウント名代わりにする
    # &.:ぼっち演算子（profileがnilではなかった場合だけ.nicknameを実行）
    profile&.nickname || self.email.split('@').first
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

  def avatar_image
    # attached?:画像がアップロードされているかどうか判定
    # .avatarは空の枠のようなオブジェクトが存在する状態で、ファイルがアップロードされているとは限らない
    # profileが存在する場合はavatarメソッドに進み、profileが存在しない場合はnilを返す（エラーにならない）
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
end
