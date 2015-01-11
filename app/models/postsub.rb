# == Schema Information
#
# Table name: postsubs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Postsub < ActiveRecord::Base
  validates :post, :sub, presence: true

  belongs_to :post, inverse_of: :postsubs
  belongs_to :sub
end
