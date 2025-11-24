# == Schema Information
#
# Table name: relationships
#
#  id           :integer          not null, primary key
#  following_id :integer          not null
#  follower_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_relationships_on_follower_id   (follower_id)
#  index_relationships_on_following_id  (following_id)
#

class Relationship < ApplicationRecord
    # class_name = この関連がどのモデルを参照しているかを示す
    # belongs_to :xx = Railsが自動でfollower, followingメソッドを作る（following_id, follower_idを使ってUserモデルからレコードを取得する）
    belongs_to :follower, class_name: 'User'
    belongs_to :following, class_name: 'User'

    # after_create = Rails側でActiveRecordモデル向けに用意しているコールバックで、モデルで定義すれば、レコード作成のタイミングで自動的に呼ばれる（before_createもある）
    # after_create = Relationshipが作成され、保存された時
    after_create :send_email

    private
    def send_email
        # 誰かがフォローされた時にメールを送信する
        # following, followerメソッドの返り値（following_id, follower_idを使ってUserモデルから取得したレコード）が引数に入る
        RelationshipMailer.new_follower(following, follower).deliver_now
    end
end
