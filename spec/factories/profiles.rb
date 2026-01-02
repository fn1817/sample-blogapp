FactoryBot.define do
  # profileというfactoryを作成（Profileモデルの設定を読み込み、カラムに値を入力したダミーデータを作成）
  factory :profile do
    nickname { Faker::Name.name }
    # ランダムな100文字を生成
    introduction { Faker::Lorem.characters(number: 100) }
    # sample = 配列の中からランタムで一つ取り出す
    gender { Profile.genders.keys.sample }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
