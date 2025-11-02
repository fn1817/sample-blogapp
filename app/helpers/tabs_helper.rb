# module = classに組み込むためのもの（classに機能を追加する）
module TabsHelper
    # 使いたいメソッドを定義
    # current_pageがtrueであれば、classにactiveがつき、そうでなければ何もつかない
    def add_active_class(path)
        'active' if current_page?(path)
    end
end
