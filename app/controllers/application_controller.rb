class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    set_current_tenant_through_filter
    before_action :set_tenant, if: :user_signed_in?

    #Suggestion: Can be moved to a concern for reusability
    def set_tenant
        condition = current_user \
        && current_user.tenant_id.present? \
        && current_user.tenants.include?(current_user.tenant)

        if condition
            #current_account = Tenant.first
            #current_account = Tenant.find_by(id: current_user.tenant_id)
            current_account = current_user.tenant #=> ActAsTenant.current_tenant
            set_current_tenant(current_account)
        else
            set_current_tenant(nil)
        end
    end
end
