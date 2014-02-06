class EventGiveawaysController < ApplicationController
  before_action :set_event_giveaway, only: [:show, :edit, :update, :destroy]

  # GET /event_giveaways
  # GET /event_giveaways.json
  def index
    if params[:event_id]
        @event = Event.find(params[:event_id])
        @event_giveaways = @event.event_giveaways
    else
        @event_giveaways = EventGiveaway.all
    end
  end

  # GET /event_giveaways/1
  # GET /event_giveaways/1.json
  def show
  end

  # GET /event_giveaways/new
  def new
    if params[:event_id]
        @event = Event.find(params[:event_id])
        @event_giveaway = EventGiveaway.new(event_id: @event.id)
    else
        @event_giveaway = EventGiveaway.new
    end
  end

  # GET /event_giveaways/1/edit
  def edit
  end

  # POST /event_giveaways
  # POST /event_giveaways.json
  def create
    @event_giveaway = EventGiveaway.new(event_giveaway_params)

    respond_to do |format|
      if @event_giveaway.save
        format.html { redirect_to @event_giveaway, notice: 'Event giveaway was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event_giveaway }
      else
        format.html { render action: 'new' }
        format.json { render json: @event_giveaway.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_giveaways/1
  # PATCH/PUT /event_giveaways/1.json
  def update
    respond_to do |format|
      if @event_giveaway.update(event_giveaway_params)
        format.html { redirect_to @event_giveaway, notice: 'Event giveaway was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event_giveaway.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_giveaways/1
  # DELETE /event_giveaways/1.json
  def destroy
    @event_giveaway.destroy
    respond_to do |format|
      format.html { redirect_to event_giveaways_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_giveaway
      @event_giveaway = EventGiveaway.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_giveaway_params
      params.require(:event_giveaway).permit(:event_id, :giveaway_id, :count_given_away, :giveaway_attributes)
    end
end
