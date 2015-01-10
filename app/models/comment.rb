class Comment < ActiveRecord::Base
  validates :content, :commenter_id, :post_id, presence: true

  belongs_to :post
  belongs_to :commenter, :class_name => "User"
  has_many :child_comments, class_name: 'Comment', foreign_key: :parent_comment_id

end
