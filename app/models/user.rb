# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  extend FriendlyId

  friendly_id :username, use: :slugged
  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  before_validation :ensure_session_token

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :commenter_id
  has_many :votes, foreign_key: :voter_id

  def self.find_by_credentials(credentials)
    user = User.find_by(username: credentials[:username])

    return nil if user.nil?

    user.is_correct_password?(credentials[:password]) ? user : nil
  end

  def is_correct_password?(password_string)
    BCrypt::Password.new(self.password_digest).is_password?(password_string)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

end
