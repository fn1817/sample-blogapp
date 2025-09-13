class Article < ApplicationRecord
    # titleが入力されていないと保存しません
    validates :title, presence: true
    # contentが入力されていないと保存しません
    validates :content, presence: true
end
