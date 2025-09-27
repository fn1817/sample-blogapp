class Profile < ApplicationRecord
    # 性別のパターンを定義（Railsの機能）
    # enum :パターンの対象, {ハッシュキー: 値, ...}
    # Profile.gendersで全てのハッシュのキーと値を取得可能（Rails側で用意されたメソッド）
    enum :gender, { male: 0, female: 1, other: 2 }
    # プロフィールはUserモデルに所属している
    belongs_to :user
    # has_one_attached:Active Storageのメソッドで、モデルに「1つのファイルを添付できる」ことを宣言
    # Profileでアバター画像をアップロード・取得できるようにする
    has_one_attached :avatar

    def age
        # birthdayが入力されていなければ'不明'と返す
        return '不明' unless birthday.present?
        # 現在の年から誕生年を引いたものをyearsに代入
        years = Time.zone.now.year - birthday.year
        # 誕生日が来たかどうか
        # 今日のydayから誕生日のydayを引くと
        # 正の値(今日のyday > 誕生日のyday) → 誕生日はもう過ぎた
        # 負の値(今日のyday < 誕生日のyday) → まだ誕生日が来ていない
        # yday:1年の始まりから日付を足す（例：2/2なら31+2=33）
        days = Time.zone.now.yday - birthday.yday

        # daysが負の値であれば、誕生日はまだ来ていないのでyearsを-1する
        if days < 0
            "#{years - 1}歳"
        else
            "#{years}歳"
        end
    end
end
