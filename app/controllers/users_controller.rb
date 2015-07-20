class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users/1
  # GET /users/1.json
  def show

  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to "/assignments" }
      format.json { head :no_content }
    end
  end

end