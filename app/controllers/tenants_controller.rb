class TenantsController < ApplicationController
  before_action :set_tenant, only: %i[ show edit update destroy switch ]

  # GET /tenants or /tenants.json
  def index
    @tenants = Tenant.all
  end

  def switch
    #Restrict access for the tenants of the current user
    if current_user.tenants.include?(@tenant)
      current_user.update(tenant_id: @tenant.id)
      redirect_to user_tenants_tenants_path,
                  notice: "Switched to tenant: #{@tenant.name}"
    else
      redirect_to user_tenants_tenants_path,
                  alert: "You are not authorized to switch to this tenant : #{@tenant.name}"
    end
  end

  # Get current logged in user's tenants
  def user_tenants
    @tenants = current_user.tenants
    render :index
  end

  # GET /tenants/1 or /tenants/1.json
  def show
  end

  # GET /tenants/new
  def new
    @tenant = Tenant.new
  end

  # GET /tenants/1/edit
  def edit
  end

  # POST /tenants or /tenants.json
  def create
    @tenant = Tenant.new(tenant_params)

    respond_to do |format|
      if @tenant.save
        # Create a member for the current user in the newly created tenant
        @member = Member.create(user_id: current_user.id, tenant_id: @tenant.id)

        #Set the current user as the owner of the tenant
        current_user.update(tenant_id: @tenant.id)

        format.html { redirect_to @tenant, notice: "Tenant was successfully created." }
        format.json { render :show, status: :created, location: @tenant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tenants/1 or /tenants/1.json
  def update
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to @tenant, notice: "Tenant was successfully updated." }
        format.json { render :show, status: :ok, location: @tenant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tenants/1 or /tenants/1.json
  def destroy
    @tenant.destroy!

    respond_to do |format|
      format.html { redirect_to user_tenants_tenants_path, status: :see_other, notice: "Tenant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tenant_params
      params.require(:tenant).permit(:name)
    end
end
