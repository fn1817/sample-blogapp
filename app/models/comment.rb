# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  article_id :integer          not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#

class Comment < ApplicationRecord
    # コメントはArticleモデルに所属している
    belongs_to :article
    # contentが入力されていないと保存しません
    validates :content, presence: true
end
