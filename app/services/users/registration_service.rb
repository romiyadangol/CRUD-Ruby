# # app/services/users/registration_service.rb
# module Users
#   class RegistrationService
#     attr_reader :params, :organization_id
#     attr_accessor :success, :errors

#     def initialize(params = {}, organization_id = nil)
#       @params = params
#       @organization_id = organization_id
#       @success = false
#       @errors = []
#     end

#     def execute
#       handle_registration
#       self
#     end

#     def success?
#       @success && @errors.empty?
#     end

#     def errors
#       @errors.join(', ')
#     end

#     private

#     def handle_registration
#       ActiveRecord::Base.transaction do
#         user = User.new(signup_params)

#         if user.save
#           if organization
#             Membership.create!(user_id: user.id, organization_id: organization.id)
#           end
#           @success = true
#         else
#           @errors.concat(user.errors.full_messages)
#         end
#       end
#     rescue ActiveRecord::RecordInvalid => e
#       @success = false
#       @errors << e.message
#     rescue ActiveRecord::RecordNotFound => e
#       @success = false
#       @errors << "Organization not found"
#     end

#     def organization
#       @organization ||= Organization.find_by(id: @organization_id) if @organization_id.present?
#     end

#     def signup_params
#       params.require(:user).permit(:email, :password, :password_confirmation)
#     end
#   end
# end
