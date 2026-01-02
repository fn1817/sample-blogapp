require 'rails_helper'

# describe = 何に関するテストを実施するか
RSpec.describe 'Profile', type: :system do
  # userの作成
  # let!(:user) = 変数userの宣言（user = と同じ意味）
  # { create(:user) } = factoryの:user（ダミーデータ）の呼び出し
  # with_profile = users.rbのwith_profileで記述した内容が実行される（factoryで指定したuserが作成された時にプロフィールも作成される）
  let!(:user) { create(:user, :with_profile) }

  # 前提条件
  context 'ログインしている場合' do
    # 前提条件の内容
    before do
      # Deviseにはsign_inメソッドがあり、sign_in user名でログイン可能だが、system spec + sign_in は相性が悪くエラーとなってしまったので、
      # Deviseの奥にいる本人認証エンジンであるWardenに直接ログインを指示
      # user = 宣言したuser, scope: :user = Deviseの世界の設定名（Deviseは複数のログイン対象を扱える設計になっているので、どの種類のログインか指定）
      login_as(user, scope: :user)
    end

    # 確認したいことを書く
    it '自分のプロフィールを確認できる' do
      # capybaraのvisitメソッド（指定したpathをブラウザで開く）を使用
      visit profile_path
      # ダミーデータで確認したいことが起こるか確認する
      # have_css = capybaraのメソッド（そのcssのclassがあるかないか + classが持っているタグのテキストがuser.profile.nicknameと一致するか判断する）
      expect(page).to have_css('.profilePage_user_displayName', text: user.profile.nickname)
    end
  end
end
