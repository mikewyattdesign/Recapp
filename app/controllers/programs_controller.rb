class ProgramsController < ApplicationController
  load_and_authorize_resource

  before_action :set_program, only: [:show, :edit, :update, :approve, :destroy]

  # GET /brands/:brand_id/programs
  # GET /brands/:brand_id/programs.json
  def index
    @brand = Brand.find(params[:brand_id])
    if current_user.is_approver? || current_user.is_super_admin? || current_user.is_admin? || current_user.is_g360?
      @programs = @brand.programs
    else
      @programs = current_user.programs.where(brand_id: @brand.id)
    end
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
      if current_user.is_client? && !@program.approved
        redirect_to brand_programs_path(@program.brand)
      else
        @report = ProgramReport.new(@program, current_user)
        respond_to do |format|
          format.html
          format.json
          format.pdf do
              return render pdf: "#{@program.id}_#{@program.name}",
                        template: '/programs/show.pdf.erb',
                        layout: "/layouts/pdf.html.erb",
                        redirect_delay: 200,
                        disable_javascript: false,
                        orientation: 'Landscape',
                        encoding: "UTF-8",
                        margin:  { top: 0, bottom: 0, left: 0, right: 0},
                        page_size: 'Letter',
                        show_as_html: params[:debug].present?,
                        locals: {program_decorator: @program_decorator}
              if (@program.report.present? && @program.report.report.present?)
                send_file Paperclip.io_adapters.for(@program.report.report).path
              else
                Delayed::Job.enqueue GeneratePdfJob.new(@program.id, Program.name)
                redirect_to @program, alert: 'Report Being Generated'
              end
          end
        end
      end
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
    UserMailer.notify_approver(@program).deliver

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
        @program.update_attribute('approved', false)
        UserMailer.notify_approver(@program).deliver
        format.html { redirect_to brand_programs_path(@program.brand), notice: 'Program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    respond_to do |format|
      if @program.update_attribute('approved', true)
        format.html {
            redirect_to @program, notice: "#{@program.name} was successfully approved."
        }
        format.json { head :no_content }
      else
        format.html { render action: 'show', notice: "#{@program.name} was not approved." }
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

  def render_PDF(id)
    @program = Program.find(id)
    @report = ProgramReport.new(@program, current_user)
    doc_pdf = render_to_string  pdf: "#{@program.id}_#{@program.name}",
                      template: '/programs/show.pdf.erb',
                      layout: "/layouts/pdf.html.erb",
                      redirect_delay: 200,
                      disable_javascript: false,
                      orientation: 'Landscape',
                      encoding: "UTF-8",
                      margin:  { top: 0, bottom: 0, left: 0, right: 0},
                      page_size: 'Letter',
                      show_as_html: params[:debug].present?,
                      locals: {program_decorator: @program_decorator}

    # save PDF to disk
    pdf_path = Rails.root.join('tmp', "#{@program.id}_#{@program.name}.pdf")
    File.open(pdf_path, 'wb') do |file|
      file << doc_pdf
    end

    @program.report = Report.new(reportable_type: Program.name, reportable_id: id)
    @program.report.report = File.open(pdf_path, 'r')
    @program.report.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:name,
        :brand_id,
        :overview,
        comments_attributes: [:id, :comment_id, :program_favorite])
    end
end
