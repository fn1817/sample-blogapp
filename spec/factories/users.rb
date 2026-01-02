FactoryBot.define do
  # userというfactoryを作成（Userモデルの設定を読み込み、emailとpasswordに値を入力したダミーデータを作成）
  factory :user do
    # ランダムなメールアドレスを生成
    email { Faker::Internet.email }
    password { 'password' }

    # trait = プロフィールも同時に作成する
    trait :with_profile do
      # userがbuildされるタイミングでプロフィールもbuildする
      # after :build = factoryで指定したuserがbuildされた時に実行する
      after :build do |user|
        # profileの作成
        # user: = profileに紐づくuser, user = factoryで作成されたuser → profileに紐づくuserはfactoryで作成されたuserである
        build(:profile, user: user)
      end
    end
  end
end
