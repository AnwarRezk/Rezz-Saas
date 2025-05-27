class MembersController < ApplicationController
  include RequireTenant
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members or /members.json
  def index
    @members = Member.all
    @tenant = current_tenant
  end

  def invite
    email = params[:email]

    if email.present?
      existing_user = User.find_by(email: email)

      if existing_user
        member = Member.new(user: existing_user, tenant: current_tenant)
        if member.save
          MemberInvitationMailer.new_invitation_email(member, current_user).deliver_later
          redirect_to members_path, notice: "Member was successfully added."
        else
          redirect_to members_path, alert: "User is already a member of this tenant."
        end
      else
        user = User.invite!({ email: email }, current_user)
        if user.persisted? #Creates the entry in the database
          user.update(tenant_id: current_tenant.id)
          member = Member.create(user: user, tenant: current_tenant)
          MemberInvitationMailer.new_invitation_email(member, current_user).deliver_later
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
