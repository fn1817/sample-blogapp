require 'rails_helper'

RSpec.describe Article, type: :model do
  # let!(:user) = 変数userの宣言（user = と同じ意味）
  # { create(:user, email: 'test@test.com') } = factoryの:user（ダミーデータ）の呼び出し（emailは指定した値に上書き）
  let!(:user) { create(:user) }

  # 前提条件
  context 'タイトルと内容が入力されている場合' do
    # let!(:article) = 変数articleの宣言（article = と同じ意味）
    # { build(:article, user: user) } = factoryの:article（ダミーデータ）の呼び出し
    # user: = articleに紐づくuser, user = let!のuser → articleに紐づくuserはダミーデータが入ったuserである
    let!(:article) { build(:article, user: user) }

    # 確認したいことを書く
    it '記事を保存できる' do
      # ダミーデータで確認したいことが起こるか確認する
      # be_valid = articleが保存できる状態であるか確認する
      expect(article).to be_valid
    end
  end

  context 'タイトルの文字が一文字の場合' do
    # let!(:article) = 変数articleの宣言（article = と同じ意味）
    # { build(:article, user: user) } = factoryの:article（ダミーデータ）の呼び出し（titleは1文字に上書き）
    # user: = articleに紐づくuser, user = let!のuser → articleに紐づくuserはダミーデータが入ったuserである
    # エラーメッセージが追加されるのは、saveやcreateしたタイミングだが、以下のcreateはcreate!と同じ意味でこの文でエラーが発生すると処理が止まってしまうので、buildにする
    let!(:article) { build(:article, title: Faker::Lorem.characters(number: 1), user: user) }

    before do
      # saveは例外を出さないので、処理は止まらない
      article.save
    end

    # 確認したいことを書く
    it '記事を保存できない' do
      # ダミーデータで確認したいことが起こるか確認する
      # タイトルに関するエラーメッセージの配列の1番目の値とeq内の値がイコールであるか
      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください')
    end
  end
end
