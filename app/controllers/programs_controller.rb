class ProgramsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_program, only: [:show, :edit, :update, :destroy]

  # GET /brands/:brand_id/programs
  # GET /brands/:brand_id/programs.json
  def index
    @brand = Brand.find(params[:brand_id]) 
    if current_user.is_admin?
      @programs = @brand.programs
    else
      @programs = current_user.programs.where(brand_id: @brand.id)
    end
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
  end

  # GET /programs/new
  def new
    @brand = Brand.find(params[:brand_id])
    @program = Program.new(brand_id: @brand.id)
  end

  # GET /programs/1/edit
  def edit
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(program_params)

    respond_to do |format|
      if @program.save
        format.html { redirect_to brand_programs_path(@program.brand), notice: 'Program was successfully created.' }
        format.json { render action: 'show', status: :created, location: @program }
      else
        format.html { render action: 'new' }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to brand_programs_path(@program.brand), notice: 'Program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @brand = @program.brand
    @program.destroy
    respond_to do |format|
      format.html { redirect_to brand_programs_path(@brand) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:name, :brand_id)
    end
end
