class DocumentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    if params[:event_id] && Event.where(id: params[:event_id]).count > 0
      @event = Event.find(params[:event_id])
      @documents = @event.documents
      @descriptor = @event.name
    elsif params[:tag]
      @documents = Document.with_event.tagged_with(params[:tag])
      @descriptor = params[:tag]
    else
      @documents = Document.with_event
      @descriptor = "All"
      # @tags = tag_cloud
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
    respond_to do |format|
      format.html
      format.js {@remote = true}
    end
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to event_documents_path(@document.event.id), notice: 'Document was successfully created .' }
        format.json { render action: 'show', status: :created, location: @document }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @event = @document.event
    @document_id = @document.id
    @document.destroy
    respond_to do |format|
      format.html { redirect_to event_documents_url(@event.id) }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:doc,:documentable_id, :documentable_type)
    end
end
