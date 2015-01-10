class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  has_many :postsubs, inverse_of: :post
  has_many :subs, through: :postsubs
  has_many :comments
  belongs_to :author, class_name: 'User'

end
