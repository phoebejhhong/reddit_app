class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  has_many :postsubs, inverse_of: :post
  has_many :subs, through: :postsubs
  has_many :comments
  belongs_to :author, class_name: 'User'

  def comments_by_parent_id
    comment_hash = Hash.new { [] }
    self.comments.each do |comment|
      comment_hash[comment.parent_comment_id] <<= comment
    end

    comment_hash
  end

end
