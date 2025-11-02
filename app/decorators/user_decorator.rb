# frozen_string_literal: true

# userクラスのメソッドとして振る舞う
module UserDecorator
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
