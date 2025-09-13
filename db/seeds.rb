# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 10回繰り返す
10.times do
    # fakerを使用してテーブルデータを作成
    Article.create(
        # 5単語で構成されたランダムな文章を作る
        title: Faker::Lorem.sentence(word_count: 5),
        # 100単語で構成されたランダムな文章を作る
        content: Faker::Lorem.sentence(word_count: 100)
    )
end
