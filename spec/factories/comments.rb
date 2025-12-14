FactoryBot.define do
  # commentというfactoryを作成（Commentモデルの設定を読み込み、contentに値を入力したダミーデータを作成）
  factory :comment do
    # ランダムな300文字を生成
    content { Faker::Lorem.characters(number: 300) }
  end
end
