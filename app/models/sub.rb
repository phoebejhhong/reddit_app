class Sub < ActiveRecord::Base
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

end
