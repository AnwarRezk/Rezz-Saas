class UsersController < ApplicationController
    before_action :set_user, only: %i[ resend_invitation show ]

    def index
        @users = User.all
    end

    def resend_invitation
        if @user.invitation_accepted_at.present?
            redirect_to users_path, alert: "User has already accepted the invitation."
        else
            @user.invite! unless @user.invitation_token.present?
            redirect_to users_path, notice: "Invitation resent successfully to #{@user.email}."
        end
    end

    def show
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end