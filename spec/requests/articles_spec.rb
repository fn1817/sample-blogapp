require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  # 記事が存在して表示されるかどうか検証したいので、記事を準備する

  # userの作成
  # let!(:user) = 変数userの宣言（user = と同じ意味）
  # { create(:user) } = factoryの:user（ダミーデータ）の呼び出し
  let!(:user) { create(:user) }

  # let!(:articles) = 変数articlesの宣言（articles = と同じ意味）
  # user: = articlesに紐づくuser, user = let!のuser → articlesに紐づくuserはダミーデータが入ったuserである
  # create_list = factoryの:article（ダミーデータ）を使って、複数の記事を一度に作成する（以下は3個作る）
  let!(:articles) { create_list(:article, 3, user: user) }

  describe 'GET /articles' do
    # 確認したいことを記述する
    it '200ステータスが返ってくる' do
      # get = メソッド（パスを指定すると、コントローラーにリクエストを送れる）
      get articles_path
      # getメソッドを使うとresponseが使える
      # responseがHTTPステータス200であればOK
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /articles' do
    # ログインしていないと記事が保存できない
    # 前提条件
    context 'ログインしている場合' do
      # 前提条件の内容
      before do
        # Deviseにはsign_inメソッドがあり、sign_in user名でログイン可能だが、rspecにおいてDeviseの機能はインストールされていないので、rails_helper.rbに設定を追記する
        sign_in user
      end

      # 確認したいことを記述する
      it '記事が保存される' do
        # articleというfactoryのattributesのハッシュをfactory_botで作ってくれる（例：{title: 'aaa', content: 'bbb'}）
        # article_params = 変数（let!は事前にDBを作る時に使うので、今回は不要）
        article_params = attributes_for(:article)
        # post = メソッド（パスを指定すると、コントローラーにリクエストを送れる）
        # {article: article_params} = 作成したパラメータを送信（articles_controller.rbのarticle_paramsメソッドに合わせた形で送信）
        post articles_path({article: article_params})
        # createアクションでは、記事が保存できたらリダイレクトしているので、responseがHTTPステータス302であればOK
        expect(response).to have_http_status(302)
        # 保存されたかどうか確認する（一番最後に保存されている記事とarticle_paramsのtitle,contentが一致していれば保存されていると判断）
        expect(Article.last.title).to eq(article_params[:title])
        # contentはActiontextを使っているので、インスタンスが返ってくる→文字列を取得するためにインスタンスのbodyの値をplain_textにして取得する
        expect(Article.last.content.body.to_plain_text).to eq(article_params[:content])
      end
    end

    # 前提条件
    context 'ログインしていない場合' do
      # 確認したいことを記述する
      it 'ログイン画面に遷移する' do
        # articleというfactoryのattributesのハッシュをfactory_botで作ってくれる（例：{title: 'aaa', content: 'bbb'}）
        # article_params = 変数（let!は事前にDBを作る時に使うので、今回は不要）
        article_params = attributes_for(:article)
        # post = メソッド（パスを指定すると、コントローラーにリクエストを送れる）
        # {article: article_params} = 作成したパラメータを送信（articles_controller.rbのarticle_paramsメソッドに合わせた形で送信）
        post articles_path({article: article_params})
        # new_user_session_path = ログイン画面にリダイレクトされる
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
