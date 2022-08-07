class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  # GET /api/v1/user
  def show
    render json: {user: current_user}, status: :ok
  end
  # GET /api/v1/send_user_referral
  def send_user_referral
    link = "#{params[:link]}?referral_code=#{current_user&.referral_code}&email=#{params[:email]}"
    UserReferralSendJob.perform_later(params[:email],link)
    render json: {user: current_user}, status: :ok
  end
end
