# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  value        :integer          not null
#  voter_id     :integer          not null
#  votable_id   :integer          not null
#  votable_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ActiveRecord::Base
  validates :voter_id, :votable_type, :votable_id, presence: true
  validates :value, presence: true, inclusion: { in: [ 1, -1 ] }
  validates :voter_id, uniqueness: { scope: [:votable_type, :votable_id],
                    message: 'You already voted!'}

  belongs_to :votable, polymorphic: true
  belongs_to :voter, class_name: 'User'
end
