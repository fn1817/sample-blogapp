require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  # コメントは記事に紐づいていて、記事はユーザに紐づいているので、ユーザと記事とコメントを作る必要がある

  # userの作成
  # let!(:user) = 変数userの宣言（user = と同じ意味）
  # { create(:user) } = factoryの:user（ダミーデータ）の呼び出し
  let!(:user) { create(:user) }

  # 記事の作成
  # let!(:article) = 変数articleの宣言（article = と同じ意味）
  # user: = articleに紐づくuser, user = let!のuser → articleに紐づくuserはダミーデータが入ったuserである
  let!(:article) { create(:article, user: user) }

  # 複数のコメントの作成
  # let!(:comments) = 変数commentsの宣言（comments = と同じ意味）
  # article: = commentsに紐づくarticle, article = let!のarticle → commentsに紐づくarticleはダミーデータが入ったarticleである
  # create_list = factoryの:comment（ダミーデータ）を使って、複数のコメントを一度に作成する（以下は3個作る）
  let!(:comments) { create_list(:comment, 3, article: article) }

  describe 'GET /api/comments' do
    it '200 Status' do
      # get = メソッド（パスを指定すると、コントローラーにリクエストを送れる）
      get api_comments_path(article_id: article.id)
      # responseがHTTPステータス200であればOK
      expect(response).to have_http_status(200)

      # responseのbodyのJSONをハッシュ/配列にしてbodyに代入
      body = JSON.parse(response.body)
      # bodyの配列内の要素数(=コメント数)が作成したコメント数と一致しているか確認
      expect(body.length).to eq 3
      # bodyの配列0番目のcontentが作成したコメント1番目のcontentと一致しているか確認
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
  end
end
