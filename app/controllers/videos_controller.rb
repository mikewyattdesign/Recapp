class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    if params[:event_id] && Event.where(id: params[:event_id]).count > 0
      @event = set_event
      @videos = @event.videos
      @descriptor = @event.name
    else
      @videos = Video.all
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @event = set_event
    if @event.present?
      @video = @event.videos.new
    else
      @video = Video.new
    end
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @event = set_event
    @video = @event.videos.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video.event, notice: 'Video was successfully created.' }
        format.json { render action: 'show', status: :created, location: @video }
      else
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @event = @video.event
    @video.destroy
    respond_to do |format|
      format.html { redirect_to event_videos_url(@event.id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:media, :event_id)
    end

    def set_event
      Event.find(params[:event_id]) if params[:event_id] && Event.where(id: params[:event_id]).count > 0
    end
end
