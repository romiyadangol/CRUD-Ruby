class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  set_current_tenant_through_filter
  before_action :set_organization_as_tenant, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_organization_as_tenant
    # Only set the tenant if the current user has an organization
    if current_user.organization.present?
      set_current_tenant(current_user.organization)
    else
      # Handle the case where the user doesn't have an organization
      # For example, redirect to a page where they can select an organization
      redirect_to select_organization_path, alert: "Please select an organization."
    end
  end

  protected

  def configure_permitted_parameters
    # Permit organization_id along with other parameters for sign up and account update
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :organization_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :organization_id])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:organization_id])
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end
end
