class ArticlesController < ApplicationController
    # 指定したアクションの実行前にのみbefore_actionに記載したメソッドを実行する
    before_action :set_article, only: [ :show ]
    # ログインしていないと使えないようにする
    before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

    def index
        @articles = Article.all
        # render 'articles/index'（デフォルトで自動でrenderするようになっている）
    end

    def show

    end

    def new
        # current_user = ログインしているuserが取得できる
        # build = 空のレコードを作成する（DBにはまだ保存されない）
        @article = current_user.articles.build
    end

    def create
        # Articleクラスにて空のレコードの枠を作成し、titleとcontentの情報を入れて@articleに代入
        @article = current_user.articles.build(article_params)
        # DBに値を保存
        # もしDBに値が保存されていれば、作成された記事のページに飛ぶ
        if @article.save
            # 新しいリクエストが発生し、ページを遷移する
            redirect_to article_path(@article), notice: '保存できたよ'
        else
            # flashは成功した場合と失敗した場合で記述方式が異なる
            flash.now[:error] = '保存に失敗しました'
            # render :new→同じリクエストのままnew.html.erbを表示し直す=@articleには入力されたtitleとcontentが入っている状態でnew.html.erbを表示
            # status: :unprocessable_entity→バリデーションエラー（必須項目が空など）のときにHTTPステータスコード422を返す
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        # ログインユーザの記事一覧から該当するidの記事を探す
        # 他のユーザが編集できないようにcurrent_userで取得すること
        @article = current_user.articles.find(params[:id])
    end

    def update
        @article = current_user.articles.find(params[:id])
        # 対象の値を更新
        # もし更新できたら、更新した記事のページに飛ぶ
        if @article.update(article_params)
            # 新しいリクエストが発生し、ページを遷移する
            redirect_to article_path(@article), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした'
            # render :edit→同じリクエストのままedit.html.erbを表示し直す
            # status: :unprocessable_entity→バリデーションエラー（必須項目が空など）のときにHTTPステータスコード422を返す
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        # destroy対象のArticleレコードを取得（DELETEリクエスト時のurl:/articles/:idに入っているidを取得）
        article = current_user.articles.find(params[:id])
        # !マークをつけておくと削除されなかった時に例外が発生し、ここで処理が止まる
        # 削除行為はユーザ側ではなく、内部処理の問題のため、削除できなかった時は処理を止める必要がある
        article.destroy!
        # 新しいリクエストが発生し、ページを遷移する
        redirect_to root_path, status: :see_other, notice: '削除に成功しました'
    end

    # Strong Parameterにはprivateをつける決まりがある
    private
    # Strong Parameter
    def article_params
        # params:formから送信されるデータが入っている
        # .require(:article):パラメータの中にarticleというキーが必要です
        # .permit(:title, :content):articleキーの中でtitleとcontentのみ許可します
        params.require(:article).permit(:title, :content, :eyecatch)
    end

    def set_article
        # 取得した値をClass内で使えるようにインスタンス変数とする
        @article = Article.find(params[:id])
    end
end
