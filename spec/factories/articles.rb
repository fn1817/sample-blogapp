FactoryBot.define do
  # articleというfactoryを作成（Articleモデルの設定を読み込み、titleとcontentに値を入力したダミーデータを作成）
  factory :article do
    # ランダムな10文字を生成
    title { Faker::Lorem.characters(number: 10) }
    # ランダムな300文字を生成
    content { Faker::Lorem.characters(number: 300) }
  end
end
