module RequireTenant
  extend ActiveSupport::Concern

  included do
    before_action :require_tenant
  end

  private

  def require_tenant
    if current_tenant.nil?
      redirect_to root_path,
      alert: "You must be associated with a tenant to access this page."
    end
  end
end