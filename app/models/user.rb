class User < ApplicationRecord
  belongs_to :referrer, :class_name => 'User', foreign_key: 'referred_by', optional: true
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist
  # before_save :set_referred_by
  # attr_reader :referred_by_code
  before_create do |user|
    user.referral_code = rendom_code

  end

  def rendom_code
    SecureRandom.urlsafe_base64(9).gsub(/-|_/,('a'..'z').to_a[rand(26)])
  end
  def set_referred_by(code)
    referrer = User.find_by(referral_code: code)
    self.referrer = referrer
  end
  
end
