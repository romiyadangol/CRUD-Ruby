class OrganizationsController < ApplicationController
    def index
        @organizations = Organization.all   
    end

    def invite_user
        @organization = current_user.organization
        user = User.invite!(email: params[:email]) do |u|
            u.skip_invitation = true
        end

        @organization.users << user

        user.deliver_invitation
        redirect_to organizations_path(@organization), notice: "Invitation sent to #{params[:email]}"
    end
end
