# module = classに組み込むためのもの（classに機能を追加する）
module TabsHelper
    # 使いたいメソッドを定義
    # current_pageがtrueであれば、classにactiveがつき、そうでなければ何もつかない
    def add_active_class(path)
        path = path.split('?').first # remove path after ?
        # _tabs.html.hamlからroot_path「/」,timeline_path「/timeline」が渡されるが、current_pageのURLは言語パラメータ（「?locale=ja」など）が追加されているので、異なるURLと判断され、falseになる
        # このため、言語パラメータを除いたURLを渡す
        'active' if current_page?(path)
    end
end
