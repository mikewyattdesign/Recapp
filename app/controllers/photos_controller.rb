class PhotosController < ApplicationController
  load_and_authorize_resource

  before_action :set_photo, only: [:show, :edit, :favorite, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    if params[:event_id] && Event.where(id: params[:event_id]).count > 0
      @event = Event.find(params[:event_id])
      @photos = @event.photos
      @favorite_photos = @event.favorite_photos
      @descriptor = @event.name
      @favoritable_type = "event"
    elsif params[:program_id] && Program.where(id: params[:program_id]).count > 0
      @program = Program.find(params[:program_id])
      @photos = @program.photos
      @favorite_photos = @program.favorite_photos
      @descriptor = @program.name
      @favoritable_type = "program"
    elsif params[:brand_id] && Brand.where(id: params[:brand_id]).count > 0
      @brand = Brand.find(params[:brand_id])
      @photos = @brand.photos
      @favorite_photos = @brand.favorite_photos
      @descriptor = @brand.name
      @favoritable_type = "brand"
    else
      @photos = Photo.with_event
      @favorite_photos = @photos.where('event_favorite = ? OR program_favorite = ? OR brand_favorite = ?', true, true, true)
      @descriptor = "All"
      # @tags = tag_cloud
    end

    if params[:commit] == 'Clear'
        params[:favorites] = ''
        params[:tag] = ''
        params[:start_date] = ''
        params[:date_date] = ''
    end

    @photos = photo_tag_filter(@photos)
    @photos = photo_date_filter(@photos)
    @photos = photo_favorite_filter(@photos)
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

  # POST /photos/1/favorite
  def favorite
    puts params
    if params[:favoritable_type].present? && params[:favoritable_type] == "event"
        @photo.event_favorite = !@photo.event_favorite
        @photo.save
    elsif params[:favoritable_type].present? && params[:favoritable_type] == "program"
        @photo.program_favorite = !@photo.program_favorite
        @photo.save
    elsif params[:favoritable_type].present? && params[:favoritable_type] == "brand"
        @photo.brand_favorite = !@photo.brand_favorite
        @photo.save
    else
    end
  end


  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    if @photo.imageable_type == 'event'
        @event = @photo.event
    end
    respond_to do |format|
      if @photo.save
        format.html { redirect_to event_photos_url(@photo.event), notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
        format.js
      else
        format.html { redirect_to new_event_photo_path(@photo.event), notice: 'Photo was not successfully created' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to event_photos_url(@photo.event), notice: 'Photo was successfully updated.' }
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

  def s3_upload_complete

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_date_filter(photos)
      if params[:start_date].present? && params[:end_date].present?
        photos.where("photos.created_at >= :start_date AND photos.created_at <= :end_date",
          { start_date: Time.strptime(params[:start_date], "%m/%d/%Y"), end_date: Time.strptime(params[:end_date], "%m/%d/%Y")})
      elsif params[:start_date].present?
        photos.where("photos.created_at >= :start_date",
          { start_date: Time.strptime(params[:start_date], "%m/%d/%Y")})
      elsif params[:end_date].present?
        photos.where("photos.created_at <= :end_date",
          { end_date: Time.strptime(params[:end_date], "%m/%d/%Y")})
      else
        photos
      end
    end

    def photo_tag_filter(photos)
      if params[:tag].present?
        if @descriptor == 'All'
          @descriptor = params[:tag]
        else
          @descriptor += " #{params[:tag]}"
        end
        photos.tagged_with(params[:tag])
      else
        photos
      end
    end

    def photo_favorite_filter(photos)
        if params[:favorites].present? && params[:favorites] == 'on'
            @descriptor += " Favorited"
            photos = @favorite_photos
        else
            photos
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image,
        :imageable_id,
        :imageable_type,
        :direct_upload_url,
        :image_file_name,
        :image_file_size,
        :image_content_type,
        :tag_list )
    end

    def tag_cloud
      Photo.tag_counts_on(:tags)
    end
end
