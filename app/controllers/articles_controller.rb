class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
        # URL「/articles/:id」の「:id」をparamsで取得し、Articleの該当id行データを取得
        @article = Article.find(params[:id])
    end

    def new
        # Articleクラスにて空のレコードの枠を作成
        @article = Article.new
    end

    def create
        # Articleクラスにて空のレコードの枠を作成し、titleとcontentの情報を入れて@articleに代入
        @article = Article.new(article_params)
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

    # Strong Parameterにはprivateをつける決まりがある
    private
    # Strong Parameter
    def article_params
        # params:formから送信されるデータが入っている
        # .require(:article):パラメータの中にarticleというキーが必要です
        # .permit(:title, :content):articleキーの中でtitleとcontentのみ許可します
        puts '----------------'
        puts params
        puts '----------------'
        params.require(:article).permit(:title, :content)
    end
end
