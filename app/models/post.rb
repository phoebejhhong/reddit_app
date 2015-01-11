# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  has_many :postsubs, inverse_of: :post
  has_many :subs, through: :postsubs
  has_many :comments
  has_many :votes, as: :votable
  belongs_to :author, class_name: 'User'

  def comments_by_parent_id
    comment_hash = Hash.new { [] }
    self.comments.each do |comment|
      comment_hash[comment.parent_comment_id] <<= comment
    end

    comment_hash
  end

  def calculate_votes
    self.votes.map{ |vote| vote.value }.inject(&:+)
  end

end
