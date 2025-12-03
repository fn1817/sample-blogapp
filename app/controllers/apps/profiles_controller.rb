class Apps::ProfilesController < Apps::ApplicationController

    def show
        # ログインユーザのプロフィールを取得
        # current_user:Deviseに備わっているメソッドで、現在ログインしているユーザーオブジェクトを返す
        # user.profile:Active Record側で生成されたメソッドで、ユーザに紐づくProfileレコードを返す
        @profile = current_user.profile
    end

    def edit
        # # もしログインユーザのプロフィールが存在すれば、そのプロフィール情報を取得
        # if current_user.profile.present?
        #     @profile = current_user.profile
        # else
        #     # (userモデル)has_one(:profile)の場合はbuild_モデル名で記述するルールとなっている
        #     # 空のProfileインスタンスの作成
        #     @profile = current_user.build_profile
        # end

        # 上記と同じ内容のコードを一行で表した場合
        # current_user.profileが存在すれば、@profileに代入され、そうでなければcurrent_user.build_profileが代入される
        # @profile = current_user.profile || current_user.build_profile

        # 上記をより簡素化したコード（user.rbにメソッドを定義）
        # current_user.profileが存在すれば、@profileに代入され、そうでなければcurrent_user.build_profileが代入される
        @profile = current_user.prepare_profile
    end

    # formの保存ボタンが押されたとき
    def update
        # ログインユーザのプロフィールが存在すれば、そのプロフィールレコードを取得し、そうでなければ空のProfileインスタンス（レコード）を作成
        @profile = current_user.prepare_profile
        # 取得したレコードにform送信時に入力されたparamsを渡して上書き
        @profile.assign_attributes(profile_params)
        if @profile.save
            redirect_to profile_path, notice: 'プロフィールを更新！'
        else
            flash.now[:error] = '更新できませんでした'
            # render :edit→同じリクエストのままedit.html.hamlを表示し直す
            # status: :unprocessable_entity→バリデーションエラー（必須項目が空など）のときにHTTPステータスコード422を返す
            render :edit, status: :unprocessable_entity
        end
    end

    private
    def profile_params
        # params:formから送信されるデータが入っている
        # .require(:profile):パラメータの中にprofileというキーが必要です
        # .permit(:xx):profileキーの中でxxのみ許可します
        params.require(:profile).permit(
            :nickname,
            :introduction,
            :gender,
            :birthday,
            :subscribed,
            :avatar
        )
    end
end
