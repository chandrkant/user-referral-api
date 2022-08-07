class UserMailer < ApplicationMailer
  def send_user_referral
    @to = params[:email]
    @link = params[:link] 
    mail(to: @to, subject: "Reffer to you")
  end
end
