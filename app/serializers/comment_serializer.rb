class CommentSerializer < ActiveModel::Serializer
  # JSONとして返す値にcontentを追加
  attributes :id, :content
end
