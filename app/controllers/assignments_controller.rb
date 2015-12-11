class AssignmentsController < ApplicationController
  load_and_authorize_resource

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
    @users = User.all.order(email: :asc)
    if sort_params[:sort_role].present?
        @users = (sort_params[:sort_role] == 'asc') ? @users.sort_by{|user| user.role_in_words } : @users.sort_by{|user| user.role_in_words }.reverse
    elsif sort_params[:sort_email].present?
        @users = @users.unscope(:order).order(email: sort_params[:sort_email].to_sym)
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = set_assignment
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
    @assignment = set_assignment
  end

  # POST /assignments
  # POST /assignments.json
  def create
    if assignment_params[:assignables].present? && assignment_params[:users].present?
      assignables = assignment_params[:assignables].map do |assignable|
        if assignable.last['assignable_type'] == 'Brand'
          Brand.find(assignable.last['assignable_id'])
        else
          Program.find(assignable.last['assignable_id'])
        end
      end
      users = assignment_params[:users].map do |user|
        User.find(user.last['user_id'])
      end

      users.each do |user|
        assignables.each do |assignable|
          user.assign(assignable)
        end
      end

      assignable_names = assignables.map do |assignable|
        assignable.name
      end.to_sentence
      user_emails = users.map do |user|
        user.email
      end.to_sentence

      return redirect_to user_management_url, notice: "Assigned #{assignable_names} to #{user_emails}"
    else
      @assignment = Assignment.new(assignment_params)

      respond_to do |format|
        if @assignment.save
          format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
          format.json { render action: 'show', status: :created, location: @assignment }
        else
          format.html { render action: 'new' }
          format.json { render json: @assignment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    @assignment = set_assignment
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    if assignment_params[:assignables].present? && assignment_params[:users].present?
      assignables = assignment_params[:assignables].map do |assignable|
        if assignable.last['assignable_type'] == 'Brand'
          Brand.find(assignable.last['assignable_id'])
        else
          Program.find(assignable.last['assignable_id'])
        end
      end
      users = assignment_params[:users].map do |user|
        User.find(user.last['user_id'])
      end

      users.each do |user|
        assignables.each do |assignable|
          user.unassign(assignable)
        end
      end

      assignable_names = assignables.map do |assignable|
        assignable.name
      end.to_sentence
      user_emails = users.map do |user|
        user.email
      end.to_sentence

      return redirect_to user_management_url, notice: "Unassigned #{assignable_names} from #{user_emails}"
    else
      @assignment = set_assignment
      @assignment.destroy
      respond_to do |format|
        format.html { redirect_to assignments_url }
        format.json { head :no_content }
      end
    end
  end

  def update_role
    @user = User.find(role_params[:user_id])
    @user.update(role: role_params[:role])
    redirect_to user_management_url, notice: "Updated #{@user.email}'s role to #{@user.role_in_words}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:user_id,
        :assignable_id,
        :assignable_type,
        :users => [:user_id],
        :assignables => [:assignable_id, :assignable_type])
    end

    def role_params
      params.require(:user).permit(:user_id,:role)
    end

    def sort_params
      params.permit(:sort_email, :sort_role)
    end

    def create_params
      params.require(:assignment).permit(:users, :assignables)
    end
end
