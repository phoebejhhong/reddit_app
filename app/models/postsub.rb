class Postsub < ActiveRecord::Base
  validates :post, :sub, presence: true

  belongs_to :post, inverse_of: :postsubs
  belongs_to :sub
end
