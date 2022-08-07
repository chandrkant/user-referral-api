class UserReferralSendJob < ApplicationJob
  queue_as :default

  def perform(email,link)
    user = User.find_by(email: email)
    unless user.present?
      UserMailer.with(email: email,link: link).send_user_referral.deliver_later
    end
  end
end
