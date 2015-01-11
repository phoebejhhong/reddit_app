# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness: true
  validates :description, :moderator_id, presence: true

  belongs_to(
    :moderator,
    :class_name => 'User',
    :foreign_key => :moderator_id,
    :primary_key => :id
  )

  has_many :postsubs
  has_many :posts, through: :postsubs

  def posts_by_votes
    posts.sort_by { |post| post.calculate_votes }.reverse
  end

end
