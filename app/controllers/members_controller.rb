class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members or /members.json
  def index
    @members = Member.all
    @tenant = Tenant.first # For now, using the first tenant as requested
  end

  def invite
    # @tenant = Tenant.first # For now, using the first tenant as requested
    email = params[:email]

    if email.present?
      # Check if user exists
      user = User.find_by(email: email)

      if user
        # If user exists, try to create member
        member = Member.new(user: user)
        if member.save
          redirect_to members_path, notice: "Member was successfully added."
        else
          redirect_to members_path, alert: "User is already a member of this tenant."
        end
      else
        # If user doesn't exist, send invitation
        user = User.invite!({ email: email }, current_user)
        if user.persisted?
          # Create member after invitation
          member = Member.create(user: user)
          redirect_to members_path, notice: "Invitation sent successfully."
        else
          redirect_to members_path, alert: "Error sending invitation."
        end
      end
    else
      redirect_to members_path, alert: "Email is required."
    end
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy!

    respond_to do |format|
      format.html { redirect_to members_path, status: :see_other, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:user_id, :tenant_id)
    end
end
