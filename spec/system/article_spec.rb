require 'rails_helper'
# rails_helperでは、typeごとに設定内容が異なるので、typeを指定する必要がある

# describe = 何に関するテストを実施するか
RSpec.describe 'Article', type: :system do
  # userの作成
  # let!(:user) = 変数userの宣言（user = と同じ意味）
  # { create(:user) } = factoryの:user（ダミーデータ）の呼び出し
  let!(:user) { create(:user) }

  # let!(:articles) = 変数articlesの宣言（articles = と同じ意味）
  # user: = articlesに紐づくuser, user = let!のuser → articlesに紐づくuserはダミーデータが入ったuserである
  # create_list = factoryの:article（ダミーデータ）を使って、複数の記事を一度に作成する（以下は3個作る）
  let!(:articles) { create_list(:article, 3, user: user) }

  # 確認したいことを記述する
  it '記事一覧が表示される' do
    # capybaraのvisitメソッド（指定したpathをブラウザで開く）を使用
    visit root_path
    articles.each do |article|
      # ダミーデータで確認したいことが起こるか確認する（そのページにそれぞれの記事のタイトルが存在するかどうか）
      # have_css = capybaraのメソッド（そのcssのclassがあるかないか + classが持っているタグのテキストがarticle.titleと一致するか判断する）
      expect(page).to have_css('.card_title', text: article.title)
    end
  end

  # 確認したいことを記述する
  it '記事の詳細を表示できる' do
    # capybaraのvisitメソッド（指定したpathをブラウザで開く）を使用
    visit root_path
    # 最初の記事を取得
    article = articles.first
    # 記事のタイトルをクリックしたら、記事の詳細が表示される
    # click_on = capybaraのメソッド（文字列を指定すると、文字列に合致するaタグをクリックする）
    click_on article.title
    # articlesのshow.html.hamlに遷移して、指定したtitleとcontentが表示されていることを確認
    expect(page).to have_css('.article_title', text: article.title)
    expect(page).to have_css('.article_content', text: article.content.to_plain_text)
  end
end
