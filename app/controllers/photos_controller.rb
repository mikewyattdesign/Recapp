class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    if params[:event_id] && Event.where(id: params[:event_id]).count > 0
      @event = Event.find(params[:event_id])
      @photos = @event.photos
      @descriptor = @event.name
    else
      @photos = Photo.none
      @descriptor = "No"
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @event = Event.find(params[:event_id])
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
    @event = @photo.event
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @event = @photo.event
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to event_photos_url(@event) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image,
        :imageable_id, 
        :imageable_type,
        :tag_list )
    end
end
