# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  commenter_id      :integer          not null
#  parent_comment_id :integer
#

class Comment < ActiveRecord::Base
  validates :content, :commenter_id, :post_id, presence: true

  belongs_to :post
  belongs_to :commenter, :class_name => "User"
  has_many :child_comments, class_name: 'Comment', foreign_key: :parent_comment_id
  has_many :votes, as: :votable

  def calculate_votes
    return 0 if votes.empty?
    self.votes.map{ |vote| vote.value }.inject(&:+)
  end
end
