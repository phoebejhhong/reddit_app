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
  extend FriendlyId

  friendly_id :title, use: :slugged

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

    comment_hash.values.each do |array|
      array.sort! { |comment1, comment2| comment2.calculate_votes <=> comment1.calculate_votes }
    end

    comment_hash
  end

  def num_of_comments
    comments.size
  end

  def calculate_votes
    return 0 if votes.empty?
    self.votes.map{ |vote| vote.value }.inject(&:+)
  end

end
